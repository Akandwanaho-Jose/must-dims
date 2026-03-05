// lib/features/student/presentation/student_dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../auth/controllers/auth_controller.dart';
import '../controllers/student_controllers.dart';
import '../../placements/data/models/placement_model.dart';
import 'pages/student_overview_page.dart';
import 'pages/logbook_page.dart';
import 'pages/my_internship_page.dart';
import 'pages/student_profile_page.dart';

// ============================================================================
// PROVIDERS
// ============================================================================

final selectedStudentTabProvider = StateProvider<int>((ref) => 0);

/// Returns a status banner widget based on current placement state.
/// Handles all cases: no placement, pending, rejected, approved (not started).
final placementStatusBannerProvider = Provider<_BannerData?>((ref) {
  final placementAsync = ref.watch(currentPlacementProvider);
  final profileAsync = ref.watch(studentProfileProvider);

  return placementAsync.when(
    data: (placement) {
      // ✅ BUG 2 FIX: Handle null placement — new student with no upload yet
      if (placement == null) {
        // Only show the upload banner if the student hasn't started the process
        final profile = profileAsync.value;
        // If internshipStatus is still notStarted, prompt them to upload
        if (profile == null ||
            profile.internshipStatus.name == 'notStarted') {
          return _BannerData(
            status: 'no_placement',
            title: 'Start Your Internship',
            subtitle: 'Upload your company acceptance letter to begin',
            color: Colors.blue,
            icon: Icons.upload_file_rounded,
            route: '/student/upload-letter',
          );
        }
        return null;
      }

      switch (placement.status) {
        case PlacementStatus.pending:
          return _BannerData(
            status: 'pending',
            title: 'Application Under Review',
            subtitle: 'Your acceptance letter is awaiting admin approval',
            color: Colors.orange,
            icon: Icons.hourglass_top_rounded,
            route: '/student/placement-status',
          );

        case PlacementStatus.rejected:
          return _BannerData(
            status: 'rejected',
            title: 'Application Rejected',
            subtitle: placement.adminNotes ?? 'Tap to upload a new letter',
            color: Colors.red,
            icon: Icons.cancel_rounded,
            route: '/student/upload-letter',
          );

        case PlacementStatus.approved:
          return _BannerData(
            status: 'approved',
            title: 'Placement Approved! 🎉',
            subtitle: 'Your placement is approved — tap to start your internship',
            color: Colors.green,
            icon: Icons.check_circle_rounded,
            route: '/student/start-internship',
          );

        default:
          // active, completed, etc. — no banner needed
          return null;
      }
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

// ============================================================================
// DATA CLASS
// ============================================================================

class _BannerData {
  final String status;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final String route;

  const _BannerData({
    required this.status,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.route,
  });
}

// ============================================================================
// STUDENT DASHBOARD
// ============================================================================

class StudentDashboard extends ConsumerWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedStudentTabProvider);
    final user = ref.watch(authStateProvider).value;
    final banner = ref.watch(placementStatusBannerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DIMS Student'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                ref.read(selectedStudentTabProvider.notifier).state = 3;
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  user?.email?.substring(0, 1).toUpperCase() ?? 'S',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Status Banner — shown when action is required from student
          if (banner != null)
            _PlacementStatusBanner(data: banner),

          // Main Content
          Expanded(
            child: IndexedStack(
              index: selectedTab,
              children: const [
                StudentOverviewPage(),
                LogbookPage(),
                MyInternshipPage(),
                StudentProfilePage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          ref.read(selectedStudentTabProvider.notifier).state = index;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Logbook',
          ),
          NavigationDestination(
            icon: Icon(Icons.business_outlined),
            selectedIcon: Icon(Icons.business),
            label: 'Internship',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PLACEMENT STATUS BANNER
// ============================================================================

class _PlacementStatusBanner extends StatelessWidget {
  final _BannerData data;

  const _PlacementStatusBanner({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(data.route),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: data.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: data.color.withOpacity(0.4), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(data.icon, color: data.color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: data.color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios_rounded,
                color: data.color, size: 14),
          ],
        ),
      ),
    );
  }
}