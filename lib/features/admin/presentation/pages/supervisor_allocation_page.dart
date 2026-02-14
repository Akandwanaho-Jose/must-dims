import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../student/data/models/student_profile_model.dart';
import '../../../supervisor/data/models/supervisor_profile_model.dart';

// ── Providers ────────────────────────────────────────────────────────────────

// Provider for unassigned students
final unassignedStudentsProvider = StreamProvider<List<StudentProfileModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('students')
      .snapshots()
      .map((snap) {
        final list = snap.docs
            .where((doc) {
              final data = doc.data();
              final supervisorId = data['currentSupervisorId'];
              return supervisorId == null || supervisorId == '';
            })
            .map((doc) {
              try {
                return StudentProfileModel.fromFirestore(doc, null);
              } catch (e) {
                print('Parse error on unassigned student ${doc.id}: $e');
                return null;
              }
            })
            .whereType<StudentProfileModel>()
            .toList();

        return list;
      })
      .handleError((e) {
        print('Unassigned query error: $e');
        return <StudentProfileModel>[];
      });
});

// Provider for assigned students
final assignedStudentsProvider = StreamProvider<List<StudentProfileModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('students')
      .snapshots()
      .map((snap) {
        final list = snap.docs
            .where((doc) {
              final data = doc.data();
              final supervisorId = data['currentSupervisorId'];
              return supervisorId != null && supervisorId != '';
            })
            .map((doc) {
              try {
                return StudentProfileModel.fromFirestore(doc, null);
              } catch (e) {
                print('Parse error on assigned student ${doc.id}: $e');
                return null;
              }
            })
            .whereType<StudentProfileModel>()
            .toList();

        return list;
      })
      .handleError((e) {
        print('Assigned query error: $e');
        return <StudentProfileModel>[];
      });
});

// Provider for total students count
final totalStudentsProvider = StreamProvider<int>((ref) {
  return FirebaseFirestore.instance
      .collection('students')
      .snapshots()
      .map((snap) => snap.docs.length)
      .handleError((e) {
        print('Total students query error: $e');
        return 0;
      });
});

final availableSupervisorsProvider = StreamProvider<List<SupervisorProfileModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('supervisorProfiles')
      .snapshots()
      .map((snap) {
        final list = snap.docs.map((doc) => SupervisorProfileModel.fromFirestore(doc, null)).toList();
        final available = list.where((sup) {
          final load = sup.currentLoad ?? 0;
          final max = sup.maxStudents ?? 12;
          final isAvailable = sup.isAvailable ?? true;
          return isAvailable && load < max;
        }).toList();

        return available;
      })
      .handleError((e) {
        print('Supervisors query error: $e');
        return <SupervisorProfileModel>[];
      });
});

final lastAssignmentResultProvider = StateProvider<String?>((ref) => null);

// ── Helper Function: Fix Supervisor Loads ───────────────────────────────────

Future<void> _fixSupervisorLoads(BuildContext context) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Recalculate Supervisor Loads?'),
      content: const Text(
        'This will count the actual number of assigned students for each supervisor '
        'and update their currentLoad field. This fixes any sync issues.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Fix Now'),
        ),
      ],
    ),
  );
  
  if (confirm != true) return;
  
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Recalculating supervisor loads...'),
        ],
      ),
    ),
  );
  
  try {
    final db = FirebaseFirestore.instance;
    
    // Get all students
    final studentsSnap = await db.collection('students').get();
    
    // Count students per supervisor
    final Map<String, List<String>> supervisorStudents = {};
    
    for (var studentDoc in studentsSnap.docs) {
      final data = studentDoc.data();
      final supervisorId = data['currentSupervisorId'];
      
      if (supervisorId != null && supervisorId != '') {
        if (!supervisorStudents.containsKey(supervisorId)) {
          supervisorStudents[supervisorId] = [];
        }
        supervisorStudents[supervisorId]!.add(studentDoc.id);
      }
    }
    
    print('========================================');
    print('SUPERVISOR LOAD RECALCULATION');
    print('========================================');
    
    // Get all supervisors and update their loads
    final supervisorsSnap = await db.collection('supervisorProfiles').get();
    final batch = db.batch();
    
    for (var supervisorDoc in supervisorsSnap.docs) {
      final supervisorId = supervisorDoc.id;
      final assignedStudents = supervisorStudents[supervisorId] ?? [];
      final actualCount = assignedStudents.length;
      
      print('Supervisor $supervisorId: $actualCount students');
      
      batch.update(supervisorDoc.reference, {
        'currentLoad': actualCount,
        'assignedStudentIds': assignedStudents,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
    
    await batch.commit();
    
    print('========================================');
    print('RECALCULATION COMPLETED');
    print('========================================');
    
    if (context.mounted) Navigator.pop(context);
    
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('✅ Recalculated loads for ${supervisorsSnap.size} supervisors'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
      ),
    );
    
  } catch (e, stackTrace) {
    print('RECALCULATION FAILED: $e');
    print('Stack trace: $stackTrace');
    
    if (context.mounted) Navigator.pop(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text('❌ Recalculation failed: $e'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}

// ── Main Widget ──────────────────────────────────────────────────────────────

class SupervisorAllocationPage extends ConsumerWidget {
  const SupervisorAllocationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final unassignedAsync = ref.watch(unassignedStudentsProvider);
    final assignedAsync = ref.watch(assignedStudentsProvider);
    final totalAsync = ref.watch(totalStudentsProvider);
    final supervisorsAsync = ref.watch(availableSupervisorsProvider);
    final lastResult = ref.watch(lastAssignmentResultProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(unassignedStudentsProvider);
          ref.invalidate(assignedStudentsProvider);
          ref.invalidate(totalStudentsProvider);
          ref.invalidate(availableSupervisorsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Supervisor Allocation',
                      style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      // Fix loads button
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 'fix_loads') {
                            _fixSupervisorLoads(context);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'fix_loads',
                            child: Row(
                              children: [
                                Icon(Icons.sync, size: 20),
                                SizedBox(width: 12),
                                Text('Recalculate Loads'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          ref.invalidate(unassignedStudentsProvider);
                          ref.invalidate(assignedStudentsProvider);
                          ref.invalidate(totalStudentsProvider);
                          ref.invalidate(availableSupervisorsProvider);
                        },
                        tooltip: 'Refresh Data',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Automatically assign students to university supervisors',
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 16),

              if (lastResult != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Chip(
                    label: Text(lastResult, style: const TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                    avatar: const Icon(Icons.check_circle, color: Colors.white),
                    onDeleted: () {
                      ref.read(lastAssignmentResultProvider.notifier).state = null;
                    },
                  ),
                ),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: theme.colorScheme.primary),
                          const SizedBox(width: 12),
                          Text('About Allocation', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text('The algorithm distributes students fairly based on:', style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      _buildBulletPoint('Program matching (preferred programs)'),
                      _buildBulletPoint('Load balancing (current vs max capacity)'),
                      _buildBulletPoint('Supervisor availability'),
                      _buildBulletPoint('Score-based assignment for optimal distribution'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Stats Grid - 3 cards showing Total, Assigned, Unassigned
              Row(
                children: [
                  Expanded(
                    child: totalAsync.when(
                      data: (total) => _StatCard(
                        title: 'Total Students',
                        value: total.toString(),
                        icon: Icons.people_outline,
                        color: Colors.blue,
                      ),
                      loading: () => _buildShimmerCard('Total Students', Icons.people_outline, Colors.blue),
                      error: (_, __) => const _StatCard(title: 'Total Students', value: '0', icon: Icons.people_outline, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: assignedAsync.when(
                      data: (students) => _StatCard(
                        title: 'Assigned',
                        value: students.length.toString(),
                        icon: Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                      loading: () => _buildShimmerCard('Assigned', Icons.check_circle_outline, Colors.green),
                      error: (_, __) => const _StatCard(title: 'Assigned', value: '0', icon: Icons.check_circle_outline, color: Colors.green),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: unassignedAsync.when(
                      data: (students) => _StatCard(
                        title: 'Unassigned',
                        value: students.length.toString(),
                        icon: Icons.person_outline,
                        color: Colors.orange,
                      ),
                      loading: () => _buildShimmerCard('Unassigned', Icons.person_outline, Colors.orange),
                      error: (err, stack) {
                        print('Unassigned error: $err');
                        return const _StatCard(title: 'Unassigned', value: '0', icon: Icons.person_outline, color: Colors.orange);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Supervisors card
              supervisorsAsync.when(
                data: (sups) => _StatCard(
                  title: 'Available Supervisors',
                  value: sups.length.toString(),
                  icon: Icons.supervised_user_circle_outlined,
                  color: Colors.purple,
                  subtitle: sups.isNotEmpty 
                      ? '${sups.map((s) => s.currentLoad ?? 0).reduce((a, b) => a + b)} / ${sups.map((s) => s.maxStudents ?? 12).reduce((a, b) => a + b)} capacity used' 
                      : null,
                ),
                loading: () => _buildShimmerCard('Available Supervisors', Icons.supervised_user_circle_outlined, Colors.purple),
                error: (_, __) => const _StatCard(title: 'Available Supervisors', value: '0', icon: Icons.supervised_user_circle_outlined, color: Colors.purple),
              ),

              const SizedBox(height: 32),

              Center(
                child: Column(
                  children: [
                    FilledButton.icon(
                      onPressed: unassignedAsync.value?.isEmpty ?? true
                          ? null
                          : () => _runAutoAssignment(context, ref),
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Run Auto Assignment'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        minimumSize: const Size(280, 56),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Manual assignment coming soon')),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Manual Assignment'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        minimumSize: const Size(280, 56),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      if (unassignedAsync.value?.isEmpty ?? false)
                        Column(
                          children: const [
                            Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
                            SizedBox(height: 16),
                            Text('All students assigned!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('No unassigned students remaining'),
                          ],
                        )
                      else if (lastResult != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Last Assignment', style: theme.textTheme.titleMedium),
                            const SizedBox(height: 8),
                            Text(lastResult, style: theme.textTheme.bodyLarge),
                          ],
                        )
                      else
                        Column(
                          children: [
                            Icon(Icons.assignment_outlined, size: 64, color: theme.colorScheme.onSurfaceVariant),
                            const SizedBox(height: 16),
                            Text('Ready to assign', style: theme.textTheme.titleMedium),
                            const SizedBox(height: 8),
                            const Text('Click the button above to start allocation', textAlign: TextAlign.center),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerCard(String title, IconData icon, Color color) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: _StatCard(
        title: title,
        value: '···',
        icon: icon,
        color: color,
      ),
    );
  }

  Future<void> _runAutoAssignment(BuildContext context, WidgetRef ref) async {
    final unassignedBefore = ref.read(unassignedStudentsProvider).value?.length ?? 0;

    if (unassignedBefore == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No students to assign')),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Run Auto Assignment?'),
        content: Text('This will assign $unassignedBefore unassigned students to available supervisors.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Assign Now')),
        ],
      ),
    );

    if (confirm != true) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Assigning students...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      final functions = FirebaseFunctions.instance;
      final result = await functions.httpsCallable('assignSupervisors').call({
        'reAssignAll': false,
      });

      if (!context.mounted) return;
      Navigator.pop(context);

      final message = result.data['message'] as String;
      final count = result.data['assignedCount'] as int;

      ref.read(lastAssignmentResultProvider.notifier).state = '$count students assigned';

      // Force immediate refresh
      ref.invalidate(unassignedStudentsProvider);
      ref.invalidate(assignedStudentsProvider);
      ref.invalidate(totalStudentsProvider);
      ref.invalidate(availableSupervisorsProvider);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 6),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Assignment failed: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 6),
        ),
      );
    }
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              value,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}