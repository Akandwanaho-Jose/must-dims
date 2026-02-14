// lib/features/student/presentation/pages/my_internship_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dims/features/student/controllers/student_controllers.dart';
import 'package:dims/features/placements/data/models/placement_model.dart';

class MyInternshipPage extends ConsumerWidget {
  const MyInternshipPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placementAsync = ref.watch(currentPlacementProvider);
    final companyAsync = ref.watch(placementCompanyProvider);
    final supervisorAsync = ref.watch(currentSupervisorProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentPlacementProvider);
          ref.invalidate(placementCompanyProvider);
          ref.invalidate(currentSupervisorProvider);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Academic Supervisor Section (NEW)
              _buildAcademicSupervisorCard(context, supervisorAsync, theme),
              
              const SizedBox(height: 16),
              
              // Placement Information
              placementAsync.when(
                data: (placement) {
                  if (placement == null) {
                    return _buildNoPlacementCard(theme);
                  }
                  return _buildPlacementContent(
                    context,
                    placement,
                    companyAsync,
                    theme,
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stack) => _buildErrorCard(context, ref, error),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // NEW: Academic Supervisor Card
  // ══════════════════════════════════════════════════════════════════════════
  
  Widget _buildAcademicSupervisorCard(
    BuildContext context,
    AsyncValue supervisorAsync,
    ThemeData theme,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.school,
                  color: theme.colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Academic Supervisor',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            
            supervisorAsync.when(
              data: (supervisor) {
                if (supervisor == null) {
                  return _buildNoSupervisorAssigned(theme);
                }
                
                return Column(
                  children: [
                    _InfoRow(
                      icon: Icons.person,
                      label: 'Name',
                      value: supervisor.fullName,
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(
                      icon: Icons.business,
                      label: 'Department',
                      value: supervisor.department,
                    ),
                    const SizedBox(height: 12),
                    _CopyableInfoRow(
                      icon: Icons.email,
                      label: 'Email',
                      value: supervisor.email,
                    ),
                    if (supervisor.phoneNumber != null) ...[
                      const SizedBox(height: 12),
                      _CopyableInfoRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: supervisor.phoneNumber!,
                      ),
                    ],
                  ],
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => _buildSupervisorError(theme, error),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoSupervisorAssigned(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'No academic supervisor assigned yet. Please contact your department.',
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupervisorError(ThemeData theme, Object error) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Error loading supervisor information',
              style: TextStyle(color: Colors.red.shade700),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Placement Content
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildPlacementContent(
    BuildContext context,
    PlacementModel placement,
    AsyncValue companyAsync,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: _getStatusColor(placement.status),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            placement.status.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Company info card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.business,
                      color: theme.colorScheme.primary,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Company',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          companyAsync.when(
                            data: (company) => Text(
                              company?.name ?? 'Loading...',
                              style: theme.textTheme.bodyLarge,
                            ),
                            loading: () => const Text('Loading...'),
                            error: (_, __) => const Text('Error loading company'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (placement.companySupervisorName != null) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Company Supervisor',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.person,
                    label: 'Name',
                    value: placement.companySupervisorName!,
                  ),
                  if (placement.companySupervisorEmail != null) ...[
                    const SizedBox(height: 12),
                    _CopyableInfoRow(
                      icon: Icons.email,
                      label: 'Email',
                      value: placement.companySupervisorEmail!,
                    ),
                  ],
                  if (placement.companySupervisorPhone != null) ...[
                    const SizedBox(height: 12),
                    _CopyableInfoRow(
                      icon: Icons.phone,
                      label: 'Phone',
                      value: placement.companySupervisorPhone!,
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Duration card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Duration',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _InfoTile(
                        icon: Icons.calendar_today,
                        label: 'Start Date',
                        value: _formatDate(placement.startDate),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _InfoTile(
                        icon: Icons.event,
                        label: 'End Date',
                        value: _formatDate(placement.endDate),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _InfoTile(
                  icon: Icons.school,
                  label: 'Academic Year',
                  value: placement.academicYear,
                ),
                if (placement.actualEndDate != null) ...[
                  const SizedBox(height: 16),
                  _InfoTile(
                    icon: Icons.check_circle,
                    label: 'Actual End Date',
                    value: _formatDate(placement.actualEndDate!),
                  ),
                ],
              ],
            ),
          ),
        ),

        if (placement.remarks != null) ...[
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remarks',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    placement.remarks!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],

        if (placement.attachmentUrl != null) ...[
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.attachment),
              title: const Text('Attachment Available'),
              subtitle: Text(
                placement.attachmentUrl!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: placement.attachmentUrl!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('URL copied to clipboard'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNoPlacementCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(
              Icons.business_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No Active Placement',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'You haven\'t been assigned to a company placement yet',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context, WidgetRef ref, Object error) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(currentPlacementProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // Helper Methods
  // ══════════════════════════════════════════════════════════════════════════

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getStatusColor(PlacementStatus status) {
    switch (status) {
      case PlacementStatus.active:
        return Colors.green;
      case PlacementStatus.pending:
        return Colors.orange;
      case PlacementStatus.completed:
        return Colors.blue;
      case PlacementStatus.cancelled:
        return Colors.red;
      case PlacementStatus.extended:
        return Colors.purple;
    }
  }
}

// ══════════════════════════════════════════════════════════════════════════
// Reusable Widgets
// ══════════════════════════════════════════════════════════════════════════

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
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
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CopyableInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _CopyableInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label copied to clipboard'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
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
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.copy,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}