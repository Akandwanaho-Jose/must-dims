import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../../../student/controllers/student_controllers.dart';
import '../../data/models/weekly_logbook_summary_model.dart';
import '../../controllers/logbook_controller.dart';
import '../../controllers/logbook_controller.dart' as logbook_ctrl;

class WeeklySummaryFormPage extends ConsumerStatefulWidget {
  final int weekNumber;
  final WeeklyLogbookSummaryModel? existingSummary;

  const WeeklySummaryFormPage({
    super.key,
    required this.weekNumber,
    this.existingSummary,
  });

  @override
  ConsumerState<WeeklySummaryFormPage> createState() => _WeeklySummaryFormPageState();
}

class _WeeklySummaryFormPageState extends ConsumerState<WeeklySummaryFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _overviewController = TextEditingController();
  final _accomplishmentsController = TextEditingController();
  final _challengesController = TextEditingController();
  final _skillsController = TextEditingController();
  final _lessonsController = TextEditingController();
  
  bool _isLoading = true;
  bool _isSubmitting = false;
  double _totalHours = 0.0;
  List<String> _dailyEntryIds = [];
  DateTime? _weekStartDate;
  DateTime? _weekEndDate;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      if (widget.existingSummary != null) {
        // Load existing summary
        _loadExistingSummary();
      } else {
        // Auto-compile from daily entries
        await _compileFromDailyEntries();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _loadExistingSummary() {
    final summary = widget.existingSummary!;
    _overviewController.text = summary.weeklyOverview;
    _accomplishmentsController.text = summary.keyAccomplishments ?? '';
    _challengesController.text = summary.challengesSummary ?? '';
    _skillsController.text = summary.skillsAcquired ?? '';
    _lessonsController.text = summary.lessonsLearned ?? '';
    _totalHours = summary.totalHoursWorked;
    _dailyEntryIds = summary.dailyEntryIds;
    _weekStartDate = summary.weekStartDate;
    _weekEndDate = summary.weekEndDate;
  }

  Future<void> _compileFromDailyEntries() async {
    final controller = ref.read(logbook_ctrl.logbookControllerProvider);
    final compiled = await controller.compileDailyEntriesForWeek(widget.weekNumber);

    setState(() {
      _dailyEntryIds = List<String>.from(compiled['dailyEntryIds']);
      _totalHours = compiled['totalHours'] as double;
      _weekStartDate = compiled['weekStartDate'] as DateTime;
      _weekEndDate = compiled['weekEndDate'] as DateTime;

      // Pre-fill with compiled data
      _overviewController.text = compiled['compiledTasks'] as String;
      if (compiled['compiledChallenges'] != null) {
        _challengesController.text = compiled['compiledChallenges'] as String;
      }
      if (compiled['compiledSkills'] != null) {
        _skillsController.text = compiled['compiledSkills'] as String;
      }
    });
  }

  @override
  void dispose() {
    _overviewController.dispose();
    _accomplishmentsController.dispose();
    _challengesController.dispose();
    _skillsController.dispose();
    _lessonsController.dispose();
    super.dispose();
  }

  Future<void> _submitSummary() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('Not logged in');

      final studentProfile = await ref.read(studentProfileProvider.future);
      if (studentProfile == null) throw Exception('Student profile not found');

      final placementId = studentProfile.currentPlacementId;
      if (placementId == null || placementId.isEmpty) {
        throw Exception('No active placement');
      }

      final summary = WeeklyLogbookSummaryModel(
        id: widget.existingSummary?.id,
        studentId: user.uid,
        placementId: placementId,
        weekNumber: widget.weekNumber,
        weekStartDate: _weekStartDate!,
        weekEndDate: _weekEndDate!,
        weeklyOverview: _overviewController.text.trim(),
        totalHoursWorked: _totalHours,
        keyAccomplishments: _accomplishmentsController.text.trim().isEmpty
            ? null
            : _accomplishmentsController.text.trim(),
        challengesSummary: _challengesController.text.trim().isEmpty
            ? null
            : _challengesController.text.trim(),
        skillsAcquired: _skillsController.text.trim().isEmpty
            ? null
            : _skillsController.text.trim(),
        lessonsLearned: _lessonsController.text.trim().isEmpty
            ? null
            : _lessonsController.text.trim(),
        dailyEntryIds: _dailyEntryIds,
        createdAt: widget.existingSummary?.createdAt ?? DateTime.now(),
      );

      if (widget.existingSummary != null) {
        await ref.read(logbook_ctrl.logbookControllerProvider).updateWeeklySummary(
          widget.existingSummary!.id!,
          summary,
        );
      } else {
        await ref.read(logbook_ctrl.logbookControllerProvider).submitWeeklySummary(summary);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.existingSummary != null
                  ? 'Weekly summary updated!'
                  : 'Weekly summary submitted for review!',
            ),
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Week ${widget.weekNumber} Summary'),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading your weekly data...'),
                ],
              ),
            )
          : _isSubmitting
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Submitting summary...'),
                    ],
                  ),
                )
              : Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      // Info Card
                      Card(
                        color: theme.colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Weekly Summary',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (_weekStartDate != null && _weekEndDate != null)
                                Text(
                                  '${DateFormat('MMM d').format(_weekStartDate!)} - ${DateFormat('MMM d, yyyy').format(_weekEndDate!)}',
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              const SizedBox(height: 8),
                              Text(
                                'Total Hours: ${_totalHours.toStringAsFixed(1)} hours',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Weekly Overview
                      Text(
                        'Weekly Overview *',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Summarize the main work you accomplished this week',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _overviewController,
                        decoration: const InputDecoration(
                          hintText: 'Provide a comprehensive overview of your weekly activities...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 6,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Weekly overview is required';
                          }
                          if (value.trim().length < 50) {
                            return 'Please provide more detail (at least 50 characters)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Key Accomplishments
                      Text(
                        'Key Accomplishments',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What were your major achievements this week?',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _accomplishmentsController,
                        decoration: const InputDecoration(
                          hintText: 'List your main accomplishments...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 24),

                      // Challenges Summary
                      Text(
                        'Challenges Summary',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Summarize any challenges you faced and how you addressed them',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _challengesController,
                        decoration: const InputDecoration(
                          hintText: 'Describe challenges and solutions...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 24),

                      // Skills Acquired
                      Text(
                        'Skills Acquired',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What new skills or knowledge did you gain this week?',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _skillsController,
                        decoration: const InputDecoration(
                          hintText: 'List new skills learned...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 24),

                      // Lessons Learned
                      Text(
                        'Lessons Learned',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What insights or lessons did you take away from this week?',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _lessonsController,
                        decoration: const InputDecoration(
                          hintText: 'Reflect on key learnings...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 32),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _submitSummary,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            widget.existingSummary != null
                                ? 'Update Summary'
                                : 'Submit for Review',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}