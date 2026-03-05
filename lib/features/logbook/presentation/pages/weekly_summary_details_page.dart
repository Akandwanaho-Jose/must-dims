import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/models/weekly_logbook_summary_model.dart';
import '../../controllers/logbook_controller.dart';

class WeeklySummaryDetailsPage extends ConsumerWidget {
  final WeeklyLogbookSummaryModel summary;

  const WeeklySummaryDetailsPage({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dailyEntriesAsync = ref.watch(dailyEntriesForWeekProvider(summary.weekNumber));

    return Scaffold(
      appBar: AppBar(
        title: Text('Week ${summary.weekNumber} Summary'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Week Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 32,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Week ${summary.weekNumber}',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${DateFormat('MMM d').format(summary.weekStartDate)} - ${DateFormat('MMM d, yyyy').format(summary.weekEndDate)}',
                                style: theme.textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _StatBox(
                          icon: Icons.access_time,
                          label: 'Total Hours',
                          value: '${summary.totalHoursWorked}',
                        ),
                        const SizedBox(width: 16),
                        _StatBox(
                          icon: Icons.event_note,
                          label: 'Daily Entries',
                          value: '${summary.dailyEntryIds.length}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Weekly Overview
            _SectionCard(
              title: 'Weekly Overview',
              content: summary.weeklyOverview,
            ),

            if (summary.keyAccomplishments != null && summary.keyAccomplishments!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Key Accomplishments',
                content: summary.keyAccomplishments!,
              ),
            ],

            if (summary.challengesSummary != null && summary.challengesSummary!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Challenges Summary',
                content: summary.challengesSummary!,
              ),
            ],

            if (summary.skillsAcquired != null && summary.skillsAcquired!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Skills Acquired',
                content: summary.skillsAcquired!,
              ),
            ],

            if (summary.lessonsLearned != null && summary.lessonsLearned!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Lessons Learned',
                content: summary.lessonsLearned!,
              ),
            ],

            // Daily Entries Section
            const SizedBox(height: 24),
            Text(
              'Daily Entries Breakdown',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            dailyEntriesAsync.when(
              data: (entries) {
                if (entries.isEmpty) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text('No daily entries found'),
                    ),
                  );
                }
                return Column(
                  children: entries.map((entry) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${entry.dayNumber}'),
                        ),
                        title: Text(DateFormat('EEEE, MMM d').format(entry.date)),
                        subtitle: Text('${entry.hoursWorked} hours'),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error loading daily entries'),
            ),

            // Supervisor Reviews
            if (summary.isReviewedByCompanySupervisor || summary.isReviewedByUniversitySupervisor) ...[
              const SizedBox(height: 24),
              Text(
                'Supervisor Reviews',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
            ],

            if (summary.isReviewedByCompanySupervisor) ...[
              _ReviewCard(
                title: 'Company Supervisor',
                rating: summary.companySupervisorRating,
                comment: summary.companySupervisorComment,
                reviewedAt: summary.companyReviewedAt,
              ),
            ],

            if (summary.isReviewedByUniversitySupervisor) ...[
              const SizedBox(height: 12),
              _ReviewCard(
                title: 'University Supervisor',
                rating: summary.universitySupervisorRating,
                comment: summary.universitySupervisorComment,
                reviewedAt: summary.universityReviewedAt,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatBox({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String content;

  const _SectionCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String title;
  final double? rating;
  final String? comment;
  final DateTime? reviewedAt;

  const _ReviewCard({
    required this.title,
    this.rating,
    this.comment,
    this.reviewedAt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                  ),
                ),
              ],
            ),
            if (rating != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('Rating: '),
                  ...List.generate(5, (index) {
                    return Icon(
                      index < rating! ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    );
                  }),
                  const SizedBox(width: 8),
                  Text(
                    '${rating!.toStringAsFixed(1)}/5.0',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
            if (comment != null && comment!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Feedback:',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(comment!),
            ],
            if (reviewedAt != null) ...[
              const SizedBox(height: 12),
              Text(
                'Reviewed: ${DateFormat('MMM d, yyyy • HH:mm').format(reviewedAt!)}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}