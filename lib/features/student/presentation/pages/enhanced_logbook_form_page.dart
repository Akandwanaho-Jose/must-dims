import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Provider for student's active placement
final studentActivePlacementProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return null;

  final studentDoc = await FirebaseFirestore.instance
      .collection('students')
      .doc(user.uid)
      .get();

  final placementId = studentDoc.data()?['currentPlacementId'] as String?;
  if (placementId == null) return null;

  final placementDoc = await FirebaseFirestore.instance
      .collection('placements')
      .doc(placementId)
      .get();

  if (!placementDoc.exists) return null;

  final placementData = placementDoc.data()!;
  
  // Calculate current week
  final startDate = (placementData['startDate'] as Timestamp?)?.toDate();
  if (startDate == null) return null;

  final now = DateTime.now();
  final daysSinceStart = now.difference(startDate).inDays;
  final currentWeek = (daysSinceStart / 7).floor() + 1;

  return {
    'placementId': placementId,
    'placement': placementData,
    'currentWeek': currentWeek,
    'startDate': startDate,
  };
});

class EnhancedLogbookFormPage extends ConsumerStatefulWidget {
  const EnhancedLogbookFormPage({super.key});

  @override
  ConsumerState<EnhancedLogbookFormPage> createState() => _EnhancedLogbookFormPageState();
}

class _EnhancedLogbookFormPageState extends ConsumerState<EnhancedLogbookFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _activitiesController = TextEditingController();
  final _skillsController = TextEditingController();
  final _challengesController = TextEditingController();
  final _hoursWorkedController = TextEditingController(text: '40');
  
  List<File> _selectedFiles = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _activitiesController.dispose();
    _skillsController.dispose();
    _challengesController.dispose();
    _hoursWorkedController.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          _selectedFiles = result.paths
              .where((path) => path != null)
              .map((path) => File(path!))
              .toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking files: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _submitLogbook(Map<String, dynamic> placementData) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('Not logged in');

      final placementId = placementData['placementId'] as String;
      final currentWeek = placementData['currentWeek'] as int;
      final startDate = placementData['startDate'] as DateTime;

      // Calculate week dates
      final weekStartDate = startDate.add(Duration(days: (currentWeek - 1) * 7));
      final weekEndDate = weekStartDate.add(const Duration(days: 6));

      // Upload attachments
      List<String> attachmentUrls = [];
      for (var file in _selectedFiles) {
        final fileName = 'logbook_attachments/${user.uid}_week${currentWeek}_${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
        final storageRef = FirebaseStorage.instance.ref().child(fileName);
        await storageRef.putFile(file);
        final url = await storageRef.getDownloadURL();
        attachmentUrls.add(url);
      }

      // Create logbook entry
      await FirebaseFirestore.instance.collection('logbookEntries').add({
        'studentId': user.uid,
        'placementId': placementId,
        'weekNumber': currentWeek,
        'weekStartDate': Timestamp.fromDate(weekStartDate),
        'weekEndDate': Timestamp.fromDate(weekEndDate),
        'activitiesPerformed': _activitiesController.text.trim(),
        'skillsLearned': _skillsController.text.trim(),
        'challengesFaced': _challengesController.text.trim(),
        'hoursWorked': double.parse(_hoursWorkedController.text.trim()),
        'attachmentUrls': attachmentUrls,
        'submittedAt': FieldValue.serverTimestamp(),
        'isReviewedByUniversitySupervisor': false,
        'isReviewedByCompanySupervisor': false,
        'status': 'submitted',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update placement progress
      final placement = placementData['placement'] as Map<String, dynamic>;
      final totalWeeks = placement['totalWeeks'] ?? 12;
      final weeksCompleted = currentWeek;
      final progressPercentage = weeksCompleted / totalWeeks;

      await FirebaseFirestore.instance
          .collection('placements')
          .doc(placementId)
          .update({
        'weeksCompleted': weeksCompleted,
        'progressPercentage': progressPercentage,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.check_circle, color: Colors.green, size: 64),
            title: const Text('Logbook Submitted!'),
            content: Text(
              'Your Week $currentWeek logbook has been submitted successfully. Your supervisors will review it soon.',
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/student/dashboard');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
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
    final placementAsync = ref.watch(studentActivePlacementProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
  title: const Text('Submit Weekly Logbook'),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => context.go('/student/dashboard'),
  ),
),
      body: placementAsync.when(
        data: (placementData) {
          if (placementData == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.orange),
                  const SizedBox(height: 16),
                  const Text('No active internship found'),
                  const SizedBox(height: 8),
                  const Text('Please start your internship first'),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => context.go('/student/dashboard'),
                    child: const Text('Go to Dashboard'),
                  ),
                ],
              ),
            );
          }

          final currentWeek = placementData['currentWeek'] as int;
          final placement = placementData['placement'] as Map<String, dynamic>;
          final totalWeeks = placement['totalWeeks'] ?? 12;

          if (currentWeek > totalWeeks) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.celebration, size: 64, color: Colors.green),
                  const SizedBox(height: 16),
                  const Text(
                    'Internship Completed!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('You have completed all required weeks'),
                ],
              ),
            );
          }

          return _isSubmitting
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Submitting logbook...'),
                    ],
                  ),
                )
              : Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      // Week Header
                      Card(
                        color: theme.colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Week $currentWeek of $totalWeeks',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: currentWeek / totalWeeks,
                                backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(0.2),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Activities Performed
                      Text(
                        'Activities Performed *',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _activitiesController,
                        decoration: const InputDecoration(
                          hintText: 'Describe what you worked on this week...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please describe your activities';
                          }
                          if (value.trim().length < 50) {
                            return 'Please provide more detail (at least 50 characters)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Skills Learned
                      Text(
                        'Skills Learned',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _skillsController,
                        decoration: const InputDecoration(
                          hintText: 'What new skills or knowledge did you gain?',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 24),

                      // Challenges Faced
                      Text(
                        'Challenges Faced',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _challengesController,
                        decoration: const InputDecoration(
                          hintText: 'Any difficulties or obstacles you encountered?',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 24),

                      // Hours Worked
                      Text(
                        'Hours Worked *',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _hoursWorkedController,
                        decoration: const InputDecoration(
                          hintText: '40',
                          border: OutlineInputBorder(),
                          suffixText: 'hours',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Required';
                          }
                          final hours = double.tryParse(value);
                          if (hours == null || hours <= 0 || hours > 168) {
                            return 'Enter valid hours (1-168)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Attachments
                      Text(
                        'Attachments (Optional)',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: _pickFiles,
                        icon: const Icon(Icons.attach_file),
                        label: Text(_selectedFiles.isEmpty
                            ? 'Add Photos/Documents'
                            : '${_selectedFiles.length} file(s) selected'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                      if (_selectedFiles.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _selectedFiles.map((file) {
                            return Chip(
                              label: Text(
                                file.path.split('/').last,
                                style: const TextStyle(fontSize: 12),
                              ),
                              onDeleted: () {
                                setState(() {
                                  _selectedFiles.remove(file);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                      const SizedBox(height: 32),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () => _submitLogbook(placementData),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Submit Logbook'),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
            ],
          ),
        ),
      ),
    );
  }
}
