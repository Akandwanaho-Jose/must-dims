import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../providers/supervisor_providers.dart';
import 'student_details_screen.dart';
import '../../../logbook/presentation/pages/weekly_summary_details_page.dart';
import 'weekly_summary_review_screen.dart';

class SupervisorOverviewContent extends ConsumerWidget {
  const SupervisorOverviewContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(supervisorProfileProvider);
    final studentsAsync = ref.watch(assignedStudentsProvider);
    final pendingSummariesAsync = ref.watch(pendingWeeklySummariesProvider);

    return profileAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (profile) {
        if (profile == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.orange),
                  const SizedBox(height: 16),
                  const Text(
                    'Supervisor Profile Not Found',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your account exists, but your supervisor profile document is missing in Firestore.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => ref.read(authControllerProvider).signOut(),
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout and Register Again'),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Welcome Header
            Text(
              'Welcome, ${profile.fullName}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),

            // Stats row
            Row(
              children: [
                _buildStatCard(
                  context,
                  'Students',
                  '${profile.currentLoad}',
                  Colors.blue,
                ),
                _buildStatCard(
                  context,
                  'Capacity',
                  '${profile.maxStudents - profile.currentLoad}',
                  Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Pending Weekly Reviews
            const Text(
              'Pending Weekly Reviews',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            pendingSummariesAsync.when(
              data: (summaries) {
                final pendingReviews = summaries
                    .where((s) => !s.isReviewedByUniversitySupervisor)
                    .toList();

                if (pendingReviews.isEmpty) {
                  return const Card(
                    child: ListTile(
                      title: Text('No pending reviews'),
                      leading: Icon(Icons.done_all, color: Colors.green),
                    ),
                  );
                }

                return Column(
                  children: pendingReviews.map((summary) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Text(
                            '${summary.weekNumber}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text('Week ${summary.weekNumber} Summary'),
                        subtitle: Text(
                          '${summary.totalHoursWorked} hours • ${summary.dailyEntryIds.length} days',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WeeklySummaryReviewScreen(
                                summary: summary,
                                isCompanySupervisor: false,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Error loading summaries: $e'),
            ),

            const SizedBox(height: 32),

            // Assigned Students
            const Text(
              'Your Students',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            studentsAsync.when(
              data: (students) {
                if (students.isEmpty) {
                  return const Text('No students assigned to you yet.');
                }
                return Column(
                  children: students.map((student) {
                    return Card(
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(student.registrationNumber),
                        subtitle: Text(student.program),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StudentDetailsScreen(student: student),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error loading students: $e'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, Color color) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}