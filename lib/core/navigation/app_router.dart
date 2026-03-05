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

// Company Supervisor imports
import 'package:dims/features/companies/presentation/pages/setup_company_supervisor_account_page.dart';
import 'package:dims/features/companies/presentation/pages/company_supervisor_dashboard.dart';
import 'package:dims/features/companies/presentation/pages/student_details_page.dart';
import 'package:dims/features/companies/presentation/pages/logbook_review_page.dart';
import 'package:dims/features/companies/presentation/pages/final_evaluation_form_page.dart';

// Admin imports
import 'package:dims/features/admin/presentation/pages/companies_management_page.dart';
import 'package:dims/features/admin/presentation/pages/pending_placements_page.dart';

// Student imports
import 'package:dims/features/student/presentation/pages/upload_acceptance_letter_page.dart';
import 'package:dims/features/student/presentation/pages/my_placement_status_page.dart';
import 'package:dims/features/student/presentation/pages/start_internship_page.dart';
import 'package:dims/features/student/presentation/pages/enhanced_logbook_form_page.dart';

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

      if (authState.isLoading) {
        print('⏳ Auth still loading, staying put');
        return null;
      }

      if (user == null) {
        final isPublicRoute = [
          '/', 
          '/login', 
          '/register',
          '/setup-company-supervisor',
        ].contains(path) || path.startsWith('/setup-company-supervisor');
        
        if (isPublicRoute) {
          print('✓ Public route, allow access');
          return null;
        }
        print('→ Not logged in, redirect to /login');
        return '/login';
      }

      if (!user.isApproved && user.role != UserRole.companySupervisor) {
        if (path == '/pending-approval') {
          print('✓ Already on pending approval page');
          return null;
        }
        print('→ Not approved, redirect to /pending-approval');
        return '/pending-approval';
      }

      switch (user.role) {
        case UserRole.student:
          print('👨‍🎓 Student role detected');
          
          final profileStatus = await ref.read(profileCheckProvider(user.uid).future);
          final profileExists = profileStatus['exists'] as bool;
          final profileIsComplete = profileStatus['isComplete'] as bool;
          
          print('Profile exists: $profileExists');
          print('Profile complete: $profileIsComplete');

          if (!profileExists) {
            if (path == '/complete-profile') {
              print('✓ Already on complete profile page');
              return null;
            }
            print('→ No profile, redirect to /complete-profile');
            return '/complete-profile';
          }

          if (!profileIsComplete) {
            if (path == '/complete-profile') {
              print('✓ Already on complete profile page');
              return null;
            }
            print('→ Profile incomplete, redirect to /complete-profile');
            return '/complete-profile';
          }

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

        case UserRole.companySupervisor:
          print('🏢 Company Supervisor role detected');
          
          if (path.startsWith('/company-supervisor/')) {
            print('✓ Company supervisor in their area');
            return null;
          }
          print('→ Redirect company supervisor to /company-supervisor/dashboard');
          return '/company-supervisor/dashboard';

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
      // ══════════════════════════════════════════════════════════════════════
      // PUBLIC ROUTES
      // ══════════════════════════════════════════════════════════════════════
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
        path: '/setup-company-supervisor',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          final companyId = state.uri.queryParameters['companyId'] ?? '';
          final companyName = state.uri.queryParameters['companyName'] ?? '';
          final supervisorName = state.uri.queryParameters['name'];

          return SetupCompanySupervisorAccountPage(
            email: email,
            companyId: companyId,
            companyName: companyName,
            supervisorName: supervisorName,
          );
        },
      ),

      // ══════════════════════════════════════════════════════════════════════
      // STUDENT ROUTES
      // ══════════════════════════════════════════════════════════════════════
      GoRoute(
        path: '/complete-profile',
        builder: (context, state) => const CompleteProfilePage(),
      ),
      GoRoute(
        path: '/student/dashboard',
        builder: (context, state) => const StudentDashboard(),
      ),
      GoRoute(
        path: '/student/upload-letter',
        builder: (context, state) => const UploadAcceptanceLetterPage(),
      ),
      GoRoute(
        path: '/student/placement-status',
        builder: (context, state) => const MyPlacementStatusPage(),
      ),
      GoRoute(
  path: '/student/start-internship',
  builder: (context, state) => const StartInternshipPage(),
),
      GoRoute(
        path: '/student/submit-logbook',
        builder: (context, state) => const EnhancedLogbookFormPage(),
      ),

      // ══════════════════════════════════════════════════════════════════════
      // UNIVERSITY SUPERVISOR ROUTES
      // ══════════════════════════════════════════════════════════════════════
      GoRoute(
        path: '/supervisor/dashboard',
        builder: (context, state) => const SupervisorDashboard(),
      ),

      // ══════════════════════════════════════════════════════════════════════
      // COMPANY SUPERVISOR ROUTES
      // ══════════════════════════════════════════════════════════════════════
      GoRoute(
        path: '/company-supervisor/dashboard',
        builder: (context, state) => const CompanySupervisorDashboard(),
      ),
      GoRoute(
        path: '/company-supervisor/student/:studentId',
        builder: (context, state) {
          final studentId = state.pathParameters['studentId']!;
          return StudentDetailsPage(studentId: studentId);
        },
      ),
      GoRoute(
        path: '/company-supervisor/review-logbook/:logbookId',
        builder: (context, state) {
          final logbookId = state.pathParameters['logbookId']!;
          return LogbookReviewPage(logbookId: logbookId);
        },
      ),
      GoRoute(
        path: '/company-supervisor/evaluate/:placementId/:studentId',
        builder: (context, state) {
          final placementId = state.pathParameters['placementId']!;
          final studentId = state.pathParameters['studentId']!;
          return FinalEvaluationFormPage(
            placementId: placementId,
            studentId: studentId,
          );
        },
      ),

      // ══════════════════════════════════════════════════════════════════════
      // ADMIN ROUTES
      // ══════════════════════════════════════════════════════════════════════
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const AdminDashboard(),
      ),
      GoRoute(
        path: '/admin/companies',
        builder: (context, state) => const CompaniesManagementPage(),
      ),
      GoRoute(
        path: '/admin/placements/pending',
        builder: (context, state) => const PendingPlacementsPage(),
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