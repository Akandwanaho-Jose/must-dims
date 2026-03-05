// lib/features/student/presentation/pages/logbook_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/student_controllers.dart';
import '../../data/models/student_profile_model.dart';
import '../../../logbook/presentation/pages/daily_entries_list_page.dart';
import '../../../logbook/presentation/pages/weekly_summaries_list_page.dart';

class LogbookPage extends ConsumerWidget {
  const LogbookPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final profileAsync = ref.watch(studentProfileProvider);

    return Scaffold(
      body: profileAsync.when(
        data: (profile) {
          final status =
              profile?.internshipStatus ?? StudentInternshipStatus.notStarted;

          // Guard: student hasn't started internship yet
          if (status == StudentInternshipStatus.notStarted ||
              status == StudentInternshipStatus.awaitingApproval) {
            return _buildNotStartedState(context, theme, status);
          }

          // Student is active, completed, etc. — show logbook tabs
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                // Tab bar
                Container(
                  color: theme.colorScheme.surface,
                  child: TabBar(
                    labelColor: theme.colorScheme.primary,
                    unselectedLabelColor:
                        theme.colorScheme.onSurfaceVariant,
                    indicatorColor: theme.colorScheme.primary,
                    tabs: const [
                      Tab(icon: Icon(Icons.event_note), text: 'Daily Entries'),
                      Tab(icon: Icon(Icons.summarize), text: 'Weekly Summaries'),
                    ],
                  ),
                ),

                // FAB for new entry
                Expanded(
                  child: Stack(
                    children: [
                      const TabBarView(
                        children: [
                          DailyEntriesListPage(),
                          WeeklySummariesListPage(),
                        ],
                      ),
                      // Floating action button to add new entry
                      Positioned(
                        bottom: 20,
                        right: 16,
                        child: FloatingActionButton.extended(
                          onPressed: () =>
                              context.go('/student/submit-logbook'),
                          icon: const Icon(Icons.add),
                          label: const Text('New Entry'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(
          child: Text('Error loading logbook'),
        ),
      ),
    );
  }

  Widget _buildNotStartedState(
    BuildContext context,
    ThemeData theme,
    StudentInternshipStatus status,
  ) {
    final isPending = status == StudentInternshipStatus.awaitingApproval;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isPending
                    ? Colors.orange.shade50
                    : Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPending ? Icons.hourglass_top : Icons.book_outlined,
                size: 56,
                color: isPending
                    ? Colors.orange.shade400
                    : Colors.blue.shade400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isPending
                  ? 'Application Pending'
                  : 'Logbook Not Yet Available',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              isPending
                  ? 'Your logbook will be available once your placement is approved and you start your internship.'
                  : 'Upload your acceptance letter and start your internship to access the logbook.',
              style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            if (!isPending)
              FilledButton.icon(
                onPressed: () => context.go('/student/upload-letter'),
                icon: const Icon(Icons.upload_file_rounded),
                label: const Text('Upload Acceptance Letter'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              )
            else
              OutlinedButton.icon(
                onPressed: () => context.go('/student/placement-status'),
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('View Application Status'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}