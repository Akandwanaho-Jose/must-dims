// lib/core/navigation/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dims/features/auth/controllers/auth_controller.dart';
import 'package:dims/features/auth/data/models/user_model.dart';
import 'package:dims/features/splash/splash_page.dart';
import 'package:dims/features/auth/presentation/login_page.dart';
import 'package:dims/features/auth/presentation/register_page.dart';
import 'package:dims/features/auth/presentation/pending_approval_page.dart';
import 'package:dims/features/student/presentation/pages/complete_profile_page.dart';
import 'package:dims/features/student/presentation/student_dashboard.dart';
import 'package:dims/features/supervisor/presentation/screens/supervisor_dashboard.dart';
import 'package:dims/features/admin/presentation/admin_dashboard.dart';

// Helper provider to check if student profile is COMPLETE
final profileCheckProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, uid) async {
  final doc = await FirebaseFirestore.instance
      .collection('students')
      .doc(uid)
      .get();
  
  if (!doc.exists || doc.data() == null) {
    print('[ProfileCheck] No profile document found for uid: $uid');
    return {'exists': false, 'isComplete': false};
  }
  
  final data = doc.data()!;
  final registrationNumber = data['registrationNumber'] as String?;
  final program = data['program'] as String?;
  final academicYear = data['academicYear'] as int?;
  
  print('═══ PROFILE CHECK ═══');
  print('UID: $uid');
  print('Registration: $registrationNumber');
  print('Program: $program');
  print('Academic Year: $academicYear');
  
  // Profile is complete if ALL critical fields are filled AND not 'PENDING'
  final isComplete = registrationNumber != null && 
                     registrationNumber.isNotEmpty && 
                     registrationNumber != 'PENDING' &&
                     program != null &&
                     program.isNotEmpty &&
                     program != 'PENDING' &&
                     academicYear != null &&
                     academicYear > 0;
  
  print('Is Complete: $isComplete');
  print('═══════════════════════');
  
  return {'exists': true, 'isComplete': isComplete};
});

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: RouterNotifier(ref),
    redirect: (BuildContext context, GoRouterState state) async {
      final path = state.uri.path;

      // Read auth state
      final authState = ref.read(authStateProvider);
      final user = authState.value;

      print('━━━ ROUTER REDIRECT ━━━');
      print('Path: $path');
      print('Auth Loading: ${authState.isLoading}');
      print('User: ${user?.email ?? "null"}');
      if (user != null) {
        print('Role: ${user.role}');
        print('Approved: ${user.isApproved}');
      }

      // 1. Still loading → wait
      if (authState.isLoading) {
        print('⏳ Auth still loading, staying put');
        return null;
      }

      // 2. Not logged in → go to login
      if (user == null) {
        final isPublicRoute = ['/', '/login', '/register'].contains(path);
        if (isPublicRoute) {
          print('✓ Public route, allow access');
          return null;
        }
        print('→ Not logged in, redirect to /login');
        return '/login';
      }

      // 3. Not approved → go to pending approval
      if (!user.isApproved) {
        if (path == '/pending-approval') {
          print('✓ Already on pending approval page');
          return null;
        }
        print('→ Not approved, redirect to /pending-approval');
        return '/pending-approval';
      }

      // 4. Role-based routing
      switch (user.role) {
        case UserRole.student:
          print('👨‍🎓 Student role detected');
          
          // Check if profile is complete
          final profileStatus = await ref.read(profileCheckProvider(user.uid).future);
          final profileExists = profileStatus['exists'] as bool;
          final profileIsComplete = profileStatus['isComplete'] as bool;
          
          print('Profile exists: $profileExists');
          print('Profile complete: $profileIsComplete');

          // Profile doesn't exist → redirect to complete profile
          if (!profileExists) {
            if (path == '/complete-profile') {
              print('✓ Already on complete profile page');
              return null;
            }
            print('→ No profile, redirect to /complete-profile');
            return '/complete-profile';
          }

          // Profile exists but incomplete → redirect to complete profile
          if (!profileIsComplete) {
            if (path == '/complete-profile') {
              print('✓ Already on complete profile page');
              return null;
            }
            print('→ Profile incomplete, redirect to /complete-profile');
            return '/complete-profile';
          }

          // Profile is complete → allow student routes
          if (path.startsWith('/student/')) {
            print('✓ Already in student area');
            return null;
          }

          print('→ Profile complete, redirect to /student/dashboard');
          return '/student/dashboard';

        case UserRole.supervisor:
          if (path == '/supervisor/dashboard' || path.startsWith('/supervisor/')) {
            print('✓ Supervisor in their area');
            return null;
          }
          print('→ Redirect supervisor to /supervisor/dashboard');
          return '/supervisor/dashboard';

        case UserRole.admin:
          if (path.startsWith('/admin/')) {
            print('✓ Admin in their area');
            return null;
          }
          print('→ Redirect admin to /admin/dashboard');
          return '/admin/dashboard';

        default:
          print('❌ Unknown role, redirect to /login');
          return '/login';
      }
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/pending-approval',
        builder: (context, state) => const PendingApprovalPage(),
      ),
      GoRoute(
        path: '/complete-profile',
        builder: (context, state) => const CompleteProfilePage(),
      ),
      GoRoute(
        path: '/student/dashboard',
        builder: (context, state) => const StudentDashboard(),
      ),
      GoRoute(
        path: '/supervisor/dashboard',
        builder: (context, state) => const SupervisorDashboard(),
      ),
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const AdminDashboard(),
      ),
    ],
  );
});

/// Listens to auth changes and triggers router refresh
class RouterNotifier extends ChangeNotifier {
  final Ref ref;

  RouterNotifier(this.ref) {
    ref.listen(authStateProvider, (_, __) {
      notifyListeners();
    });
  }
}