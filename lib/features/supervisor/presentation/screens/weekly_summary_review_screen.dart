import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../logbook/data/models/weekly_logbook_summary_model.dart';
import '../../../logbook/data/models/daily_logbook_entry_model.dart';
import '../../../logbook/controllers/logbook_controller.dart';

class WeeklySummaryReviewScreen extends ConsumerStatefulWidget {
  final WeeklyLogbookSummaryModel summary;
  final bool isCompanySupervisor;

  const WeeklySummaryReviewScreen({
    super.key,
    required this.summary,
    this.isCompanySupervisor = true,
  });

  @override
  ConsumerState<WeeklySummaryReviewScreen> createState() =>
      _WeeklySummaryReviewScreenState();
}

class _WeeklySummaryReviewScreenState
    extends ConsumerState<WeeklySummaryReviewScreen> {
  final _commentController = TextEditingController();
  double _rating = 4.0;
  bool _isSubmitting = false;
  bool _showDailyEntries = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill if already reviewed
    if (widget.isCompanySupervisor && widget.summary.isReviewedByCompanySupervisor) {
      _commentController.text = widget.summary.companySupervisorComment ?? '';
      _rating = widget.summary.companySupervisorRating ?? 4.0;
    } else if (!widget.isCompanySupervisor && widget.summary.isReviewedByUniversitySupervisor) {
      _commentController.text = widget.summary.universitySupervisorComment ?? '';
      _rating = widget.summary.universitySupervisorRating ?? 4.0;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide feedback'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final controller = ref.read(logbookControllerProvider);

      if (widget.isCompanySupervisor) {
        await controller.submitCompanyReview(
          summaryId: widget.summary.id!,
          comment: _commentController.text.trim(),
          rating: _rating,
        );
      } else {
        await controller.submitUniversityReview(
          summaryId: widget.summary.id!,
          comment: _commentController.text.trim(),
          rating: _rating,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Review submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final summary = widget.summary;

    return Scaffold(
      appBar: AppBar(
        title: Text('Review Week ${summary.weekNumber}'),
      ),
      body: _isSubmitting
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Submitting review...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Info Card
                  Card(
                    color: theme.colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Week ${summary.weekNumber}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${DateFormat('MMM d').format(summary.weekStartDate)} - ${DateFormat('MMM d, yyyy').format(summary.weekEndDate)}',
                            style: TextStyle(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${summary.totalHoursWorked} hours total',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.event_note,
                                size: 16,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${summary.dailyEntryIds.length} days',
                                style: TextStyle(
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Toggle Daily Entries Button
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() => _showDailyEntries = !_showDailyEntries);
                    },
                    icon: Icon(_showDailyEntries ? Icons.expand_less : Icons.expand_more),
                    label: Text(_showDailyEntries ? 'Hide Daily Breakdown' : 'View Daily Breakdown'),
                  ),
                  const SizedBox(height: 16),

                  // Daily Entries (Expandable)
                  if (_showDailyEntries) ...[
                    _DailyEntriesSection(weekNumber: summary.weekNumber),
                    const SizedBox(height: 24),
                  ],

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

                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 24),

                  // Review Section
                  Text(
                    'Your Review',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rating
                  Text(
                    'Overall Rating',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: _rating,
                          min: 1.0,
                          max: 5.0,
                          divisions: 8,
                          label: _rating.toStringAsFixed(1),
                          onChanged: (value) {
                            setState(() => _rating = value);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${_rating.toStringAsFixed(1)}/5.0',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < _rating.round() ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 32,
                      );
                    }),
                  ),
                  const SizedBox(height: 24),

                  // Feedback
                  Text(
                    'Feedback / Comments',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Provide constructive feedback for the student...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submitReview,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Submit Review & Endorsement',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _DailyEntriesSection extends ConsumerWidget {
  final int weekNumber;

  const _DailyEntriesSection({required this.weekNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyEntriesAsync = ref.watch(dailyEntriesForWeekProvider(weekNumber));

    return dailyEntriesAsync.when(
      data: (entries) {
        if (entries.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text('No daily entries found for this week'),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Entries Breakdown',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...entries.map((entry) => _DailyEntryCard(entry: entry)),
          ],
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Error loading daily entries: $error'),
        ),
      ),
    );
  }
}

class _DailyEntryCard extends StatelessWidget {
  final DailyLogbookEntryModel entry;

  const _DailyEntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Text(
            '${entry.dayNumber}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        title: Text(
          DateFormat('EEEE, MMM d').format(entry.date),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${entry.hoursWorked} hours worked'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tasks Performed:',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(entry.tasksPerformed),
                if (entry.challenges != null && entry.challenges!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Challenges:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(entry.challenges!),
                ],
                if (entry.skillsLearned != null && entry.skillsLearned!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Skills Learned:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(entry.skillsLearned!),
                ],
              ],
            ),
          ),
        ],
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