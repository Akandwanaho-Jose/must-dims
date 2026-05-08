import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/controllers/auth_controller.dart';
import '../../../results/final_marks_model.dart';
import '../../../student/data/models/student_profile_model.dart';
import '../../controllers/supervisor_controller.dart';

final _studentFinalMarksProvider =
    FutureProvider.family<FinalMarksModel?, String>((ref, studentId) {
  return ref
      .read(supervisorControllerProvider)
      .getFinalMarksForStudent(studentId);
});

class StudentEvaluationScreen extends ConsumerStatefulWidget {
  const StudentEvaluationScreen({super.key, required this.student});

  final StudentProfileModel student;

  @override
  ConsumerState<StudentEvaluationScreen> createState() =>
      _StudentEvaluationScreenState();
}

class _StudentEvaluationScreenState
    extends ConsumerState<StudentEvaluationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstVisitController = TextEditingController();
  final _secondVisitController = TextEditingController();
  final _companySupervisorController = TextEditingController();
  final _remarksController = TextEditingController();

  bool _isSaving = false;
  bool _prefilled = false;

  @override
  void initState() {
    super.initState();
    _firstVisitController.addListener(_refreshTotal);
    _secondVisitController.addListener(_refreshTotal);
    _companySupervisorController.addListener(_refreshTotal);
  }

  @override
  void dispose() {
    _firstVisitController.dispose();
    _secondVisitController.dispose();
    _companySupervisorController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final existingMarksAsync =
        ref.watch(_studentFinalMarksProvider(widget.student.uid));

    return Scaffold(
      appBar: AppBar(title: const Text('Award Final Marks')),
      body: existingMarksAsync.when(
        data: (existingMarks) {
          _prefill(existingMarks);
          return _buildForm(context);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final theme = Theme.of(context);
    final totalMarks = _totalMarks;

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Text(
                      widget.student.fullName.isNotEmpty
                          ? widget.student.fullName[0].toUpperCase()
                          : 'S',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.student.fullName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${widget.student.registrationNumber} • ${widget.student.program}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _MarksField(
            controller: _firstVisitController,
            label: 'First visit marks',
            icon: Icons.looks_one_rounded,
          ),
          const SizedBox(height: 12),
          _MarksField(
            controller: _secondVisitController,
            label: 'Second visit marks',
            icon: Icons.looks_two_rounded,
          ),
          const SizedBox(height: 12),
          _MarksField(
            controller: _companySupervisorController,
            label: 'Company supervisor marks',
            icon: Icons.business_center_outlined,
          ),
          const SizedBox(height: 16),
          Card(
            color: theme.colorScheme.primaryContainer.withOpacity(0.35),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.calculate_outlined,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Total marks',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    _formatMarks(totalMarks),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _remarksController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Remarks',
              prefixIcon: Icon(Icons.notes_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _isSaving ? null : _submit,
            icon: _isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(_isSaving ? 'Saving marks...' : 'Save final marks'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _prefill(FinalMarksModel? marks) {
    if (_prefilled || marks == null) return;
    _prefilled = true;
    _firstVisitController.text = _formatMarks(marks.firstVisitMarks);
    _secondVisitController.text = _formatMarks(marks.secondVisitMarks);
    _companySupervisorController.text =
        _formatMarks(marks.companySupervisorMarks);
    _remarksController.text = marks.remarks ?? '';
  }

  void _refreshTotal() {
    if (mounted) setState(() {});
  }

  double get _totalMarks =>
      _readMarks(_firstVisitController) +
      _readMarks(_secondVisitController) +
      _readMarks(_companySupervisorController);

  double _readMarks(TextEditingController controller) {
    return double.tryParse(controller.text.trim()) ?? 0;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = ref.read(authStateProvider).value;
    if (auth == null) return;

    setState(() => _isSaving = true);

    try {
      await ref.read(supervisorControllerProvider).submitFinalMarks(
            student: widget.student,
            supervisorId: auth.uid,
            supervisorName: auth.displayName ?? auth.email,
            firstVisitMarks: _readMarks(_firstVisitController),
            secondVisitMarks: _readMarks(_secondVisitController),
            companySupervisorMarks: _readMarks(_companySupervisorController),
            remarks: _remarksController.text,
          );

      ref.invalidate(_studentFinalMarksProvider(widget.student.uid));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Final marks saved')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save marks: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

class _MarksField extends StatelessWidget {
  const _MarksField({
    required this.controller,
    required this.label,
    required this.icon,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        final marks = double.tryParse(value?.trim() ?? '');
        if (marks == null) return 'Enter marks';
        if (marks < 0) return 'Marks cannot be negative';
        return null;
      },
    );
  }
}

String _formatMarks(double value) {
  return value == value.truncateToDouble()
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
}
