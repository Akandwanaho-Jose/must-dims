// lib/features/admin/presentation/pages/users_management_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dims/features/admin/controllers/users_management_controller.dart';
import 'package:dims/features/auth/data/models/user_model.dart';

const List<String> _studentLevelOptions = [
  'Year One',
  'Year Two',
  'Year Three',
  'Year Four',
];

const List<String> _studentProgramOptions = [
  'Bachelor of Information Technology',
  'Bachelor of Computer Science',
  'Bachelor of Software Engineering',
];

class UsersManagementPage extends ConsumerStatefulWidget {
  const UsersManagementPage({super.key});

  @override
  ConsumerState<UsersManagementPage> createState() => _UsersManagementPageState();
}

class _UsersManagementPageState extends ConsumerState<UsersManagementPage> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Users Management',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'View and manage all system users',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search users by name or email...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() => _searchQuery = value.toLowerCase());
                  },
                ),
              ],
            ),
          ),
          
          // Tabs
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Students'),
              Tab(text: 'Supervisors'),
            ],
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _UsersListView(
                  role: UserRole.student,
                  searchQuery: _searchQuery,
                ),
                _UsersListView(
                  role: UserRole.supervisor,
                  searchQuery: _searchQuery,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UsersListView extends ConsumerWidget {
  final UserRole role;
  final String searchQuery;

  const _UsersListView({
    required this.role,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(approvedUsersProvider(role));
    final theme = Theme.of(context);

    return usersAsync.when(
      data: (users) {
        // Filter by search query
        final filteredUsers = searchQuery.isEmpty
            ? users
            : users.where((user) {
                final email = user.email.toLowerCase();
                final name = (user.displayName ?? '').toLowerCase();
                return email.contains(searchQuery) || name.contains(searchQuery);
              }).toList();

        if (filteredUsers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  searchQuery.isEmpty ? Icons.people_outline : Icons.search_off,
                  size: 64,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  searchQuery.isEmpty
                      ? 'No ${role.name}s found'
                      : 'No results for "$searchQuery"',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(approvedUsersProvider(role));
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: filteredUsers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _UserCard(user: filteredUsers[index]);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text('Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.invalidate(approvedUsersProvider(role)),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserCard extends ConsumerWidget {
  final UserModel user;

  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: theme.colorScheme.primaryContainer,
          backgroundImage: user.photoUrl != null 
              ? NetworkImage(user.photoUrl!) 
              : null,
          child: user.photoUrl == null
              ? Text(
                  user.email[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                )
              : null,
        ),
        title: Text(
          user.displayName ?? user.email,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(user.email),
            if (user.phoneNumber != null) ...[
              const SizedBox(height: 2),
              Text(user.phoneNumber!),
            ],
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            // Show options menu
            _showUserOptions(context, ref, user);
          },
        ),
      ),
    );
  }

  void _showUserOptions(BuildContext context, WidgetRef ref, UserModel user) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('View Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to user profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit User'),
              onTap: () {
                Navigator.pop(context);
                _showEditUserDialog(context, ref, user);
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: Colors.red),
              title: const Text('Deactivate User'),
              onTap: () {
                Navigator.pop(context);
                _confirmDeactivate(context, ref, user);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeactivate(
    BuildContext context,
    WidgetRef ref,
    UserModel user,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deactivate user?'),
        content: Text(
          'This will disable ${user.displayName ?? user.email} from active access.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Deactivate'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref
          .read(usersManagementControllerProvider)
          .deactivateUser(user.uid);

      ref.invalidate(approvedUsersProvider(user.role));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${user.displayName ?? user.email} deactivated')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to deactivate user: $e')),
        );
      }
    }
  }

  Future<void> _showEditUserDialog(
    BuildContext context,
    WidgetRef ref,
    UserModel user,
  ) async {
    final controller = ref.read(usersManagementControllerProvider);

    await showDialog<void>(
      context: context,
      builder: (context) {
        return FutureBuilder<Map<String, dynamic>>(
          future: controller.getRoleDetails(user),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                content: SizedBox(
                  height: 96,
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            }

            if (snapshot.hasError) {
              return AlertDialog(
                title: const Text('Unable to load user'),
                content: Text(snapshot.error.toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              );
            }

            return _EditUserDialog(
              user: user,
              roleDetails: snapshot.data ?? const <String, dynamic>{},
            );
          },
        );
      },
    );
  }
}

class _EditUserDialog extends ConsumerStatefulWidget {
  final UserModel user;
  final Map<String, dynamic> roleDetails;

  const _EditUserDialog({
    required this.user,
    required this.roleDetails,
  });

  @override
  ConsumerState<_EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends ConsumerState<_EditUserDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _registrationController;
  late final TextEditingController _academicYearController;
  late final TextEditingController _departmentController;

  String? _selectedProgram;
  String? _selectedLevel;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.user.displayName ?? widget.roleDetails['fullName'] ?? '',
    );
    _phoneController = TextEditingController(
      text:
          widget.user.phoneNumber ?? widget.roleDetails['phoneNumber'] ?? '',
    );
    _registrationController = TextEditingController(
      text: widget.roleDetails['registrationNumber'] ?? '',
    );
    _academicYearController = TextEditingController(
      text: '${widget.roleDetails['academicYear'] ?? ''}',
    );
    _departmentController = TextEditingController(
      text: widget.roleDetails['department'] ?? '',
    );
    final storedProgram = widget.roleDetails['program'] as String?;
    final storedLevel = widget.roleDetails['currentLevel'] as String?;
    _selectedProgram = _studentProgramOptions.contains(storedProgram)
        ? storedProgram
        : null;
    _selectedLevel = _studentLevelOptions.contains(storedLevel)
        ? storedLevel
        : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _registrationController.dispose();
    _academicYearController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isStudent = widget.user.role == UserRole.student;
    final title = 'Edit ${widget.user.role.name}';

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 520,
          maxHeight: MediaQuery.of(context).size.height * 0.86,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    IconButton(
                      onPressed: _isSaving ? null : () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full name',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Full name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          initialValue: widget.user.email,
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone number',
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                        ),
                        if (isStudent) ...[
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _registrationController,
                            decoration: const InputDecoration(
                              labelText: 'Registration number',
                              prefixIcon: Icon(Icons.badge_outlined),
                            ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: _selectedProgram,
                            isExpanded: true,
                            menuMaxHeight: 320,
                            decoration: const InputDecoration(
                              labelText: 'Program',
                              prefixIcon: Icon(Icons.school_outlined),
                            ),
                            items: _studentProgramOptions
                                .map(
                                  (program) => DropdownMenuItem<String>(
                                    value: program,
                                    child: Text(
                                      program,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _selectedProgram = value),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _academicYearController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Academic year',
                              prefixIcon: Icon(Icons.calendar_today_outlined),
                            ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: _selectedLevel,
                            isExpanded: true,
                            menuMaxHeight: 280,
                            decoration: const InputDecoration(
                              labelText: 'Current level',
                              prefixIcon: Icon(Icons.grade_outlined),
                            ),
                            items: _studentLevelOptions
                                .map(
                                  (level) => DropdownMenuItem<String>(
                                    value: level,
                                    child: Text(level),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _selectedLevel = value),
                          ),
                        ] else ...[
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _departmentController,
                            decoration: const InputDecoration(
                              labelText: 'Department',
                              prefixIcon: Icon(Icons.account_tree_outlined),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 360;
                    if (compact) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FilledButton(
                            onPressed: _isSaving ? null : _saveChanges,
                            child: Text(_isSaving ? 'Saving...' : 'Save changes'),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            onPressed:
                                _isSaving ? null : () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        OutlinedButton(
                          onPressed:
                              _isSaving ? null : () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: _isSaving ? null : _saveChanges,
                          child: Text(_isSaving ? 'Saving...' : 'Save changes'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      await ref.read(usersManagementControllerProvider).updateManagedUserProfile(
            user: widget.user,
            displayName: _nameController.text,
            phoneNumber: _phoneController.text,
            registrationNumber: _registrationController.text,
            program: _selectedProgram,
            academicYear: int.tryParse(_academicYearController.text.trim()),
            currentLevel: _selectedLevel,
            department: _departmentController.text,
          );

      ref.invalidate(approvedUsersProvider(widget.user.role));

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${widget.user.displayName ?? widget.user.email} updated successfully',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
