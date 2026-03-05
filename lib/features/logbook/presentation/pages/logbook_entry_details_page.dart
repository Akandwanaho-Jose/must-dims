import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/logbook_entry_model.dart';

class LogbookEntryDetailsScreen extends StatelessWidget {
  final LogbookEntryModel entry;

  const LogbookEntryDetailsScreen({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text('Entry Details - Week ${entry.weekNumber}'), // FIXED
        actions: [
          if (entry.status.isNotEmpty) // FIXED
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Chip(
                label: Text(
                  entry.status.toUpperCase(),
                  style: TextStyle(
                    color: _getStatusTextColor(entry.status),
                  ),
                ),
                backgroundColor: _getStatusColor(entry.status),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailRow(
                      icon: Icons.calendar_today,
                      label: 'Week Period',
                      value: '${dateFormat.format(entry.weekStartDate)} - ${dateFormat.format(entry.weekEndDate)}', // FIXED
                    ),
                    const Divider(height: 32),
                    _DetailRow(
                      icon: Icons.numbers,
                      label: 'Week Number',
                      value: '${entry.weekNumber}', // FIXED
                    ),
                    const Divider(height: 32),
                    _DetailRow(
                      icon: Icons.timer,
                      label: 'Hours Worked',
                      value: '${entry.hoursWorked.toStringAsFixed(1)} hours',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tasks Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activities Performed',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      entry.activitiesPerformed, // FIXED
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Challenges & Skills
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Challenges Faced',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            entry.challengesFaced ?? 'No challenges reported', // FIXED
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: entry.challengesFaced == null ? Colors.grey : null,
                              fontStyle: entry.challengesFaced == null ? FontStyle.italic : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Skills / Knowledge Acquired',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            entry.skillsLearned ?? 'No new skills reported',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: entry.skillsLearned == null ? Colors.grey : null,
                              fontStyle: entry.skillsLearned == null ? FontStyle.italic : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Timestamps
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Timestamps',
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _TimestampRow(
                      label: 'Created',
                      value: entry.createdAt != null
                          ? DateFormat('MMM d, yyyy • HH:mm').format(entry.createdAt!)
                          : 'Unknown',
                    ),
                    const Divider(height: 24),
                    _TimestampRow(
                      label: 'Submitted',
                      value: entry.submittedAt != null
                          ? DateFormat('MMM d, yyyy • HH:mm').format(entry.submittedAt!)
                          : 'Not submitted',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade100;
      case 'rejected':
        return Colors.red.shade100;
      default:
        return Colors.orange.shade100;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade800;
      case 'rejected':
        return Colors.red.shade800;
      default:
        return Colors.orange.shade800;
    }
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimestampRow extends StatelessWidget {
  final String label;
  final String value;

  const _TimestampRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}