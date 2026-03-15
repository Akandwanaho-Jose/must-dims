import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dims/features/auth/controllers/auth_controller.dart';
import 'package:dims/features/student/controllers/student_controllers.dart';
import 'package:dims/features/student/data/models/student_profile_model.dart';
import 'package:dims/core/navigation/app_router.dart';

// List of programs in Faculty of Computing and Informatics (FCI)
const List<String> fciPrograms = [
  'Bachelor of Information Technology',
  'Bachelor of Computer Science',
  'Bachelor of Software Engineering',
];

const List<String> studentLevels = [
  'Year One',
  'Year Two',
  'Year Three',
  'Year Four',
];

class CompleteProfilePage extends ConsumerStatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  ConsumerState<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends ConsumerState<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _registrationNumberController = TextEditingController();
  final _academicYearController = TextEditingController();

  // Dropdown value for program
  String? _selectedProgram;
  String? _selectedLevel;

  bool _isLoading = false;

  @override
  void dispose() {
    _registrationNumberController.dispose();
    _academicYearController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authState = ref.read(authStateProvider).value;
      if (authState == null || authState.uid == null) {
        throw Exception('User not authenticated');
      }

      final uid = authState.uid!;
      final fullName = authState.displayName ?? 'Unknown User';

      print('━━━ SAVING PROFILE ━━━');
      print('UID: $uid');
      print('Registration: ${_registrationNumberController.text.trim()}');
      print('Program: $_selectedProgram');
      print('Year: ${_academicYearController.text.trim()}');
      print('Level: $_selectedLevel');

      // Create complete profile
      final profile = StudentProfileModel(
        uid: uid,
        fullName: fullName,
        registrationNumber: _registrationNumberController.text.trim(),
        program: _selectedProgram!,
        academicYear: int.parse(_academicYearController.text.trim()),
        currentLevel: _selectedLevel!,
        status: 'active',
        internshipStatus: StudentInternshipStatus.notStarted,
        progressPercentage: 0.0,
        currentPlacementId: null,
        currentSupervisorId: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save to Firestore
      await ref.read(studentProfileControllerProvider).saveProfile(uid, profile);
      
      print('✓ Profile saved to Firestore');

      if (!mounted) return;

      // Invalidate cached providers
      ref.invalidate(studentProfileProvider);
      ref.invalidate(profileCheckProvider(uid));
      
      print('✓ Providers invalidated');

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile completed successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }

      // Wait for providers to refresh and Firestore to sync
      await Future.delayed(const Duration(milliseconds: 1500));
      
      if (!mounted) return;
      
      print('→ Navigating to dashboard...');
      
      // Navigate to dashboard
      context.go('/student/dashboard');

    } catch (e) {
      print('❌ Error saving profile: $e');
      
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving profile: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authStateProvider).value;
    final userName = authState?.displayName ?? 'Student';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await ref.read(authControllerProvider).signOut();
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Icon(
                  Icons.person_add_alt_1_rounded,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome, $userName!',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please complete your profile to start your internship journey',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Registration Number
                TextFormField(
                  controller: _registrationNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Registration Number',
                    hintText: 'e.g., 2023/BIT/001',
                    prefixIcon: Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Registration number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Program Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedProgram,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Program',
                    hintText: 'Select your program',
                    prefixIcon: Icon(Icons.school_outlined),
                    border: OutlineInputBorder(),
                  ),
                  items: fciPrograms.map((String program) {
                    return DropdownMenuItem<String>(
                      value: program,
                      child: Text(
                        program,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedProgram = val;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your program';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Academic Year
                TextFormField(
                  controller: _academicYearController,
                  decoration: const InputDecoration(
                    labelText: 'Academic Year',
                    hintText: 'e.g., 2024',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Academic year is required';
                    }
                    final year = int.tryParse(value.trim());
                    if (year == null || year < 2000 || year > DateTime.now().year + 6) {
                      return 'Enter a valid year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Current Level
                DropdownButtonFormField<String>(
                  value: _selectedLevel,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Current Level',
                    hintText: 'Select your current year of study',
                    prefixIcon: Icon(Icons.grade_outlined),
                    border: OutlineInputBorder(),
                  ),
                  items: studentLevels.map((level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLevel = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Current level is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                // Submit Button
                FilledButton.icon(
                  onPressed: _isLoading ? null : _saveProfile,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.check_circle),
                  label: Text(_isLoading ? 'Saving...' : 'Complete Profile'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  '* All fields are required',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
