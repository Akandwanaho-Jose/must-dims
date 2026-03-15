import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dims/core/widgets/brand_app_bar_title.dart';
import 'package:dims/core/theme/must_theme.dart';

import '../../auth/controllers/auth_controller.dart';
import 'pages/overview_page.dart';
import 'pages/users_management_page.dart';
import 'pages/pending_approvals_page.dart';
import 'pages/supervisor_allocation_page.dart';
import 'pages/companies_management_page.dart';
import 'pages/pending_placements_page.dart';

// ============================================================================
// SELECTED TAB PROVIDER
// ============================================================================

final selectedAdminTabProvider = StateProvider<int>((ref) => 0);

// ============================================================================
// ADMIN DASHBOARD WITH DRAWER NAVIGATION
// ============================================================================

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedAdminTabProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: BrandAppBarTitle(
          title: _getPageTitle(selectedTab),
          subtitle: 'MUST Administration',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await ref.read(authControllerProvider).signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      drawer: _AdminDrawer(),
      body: _buildBody(selectedTab),
    );
  }

  String _getPageTitle(int tab) {
    switch (tab) {
      case 0:
        return 'Admin Dashboard';
      case 1:
        return 'User Management';
      case 2:
        return 'Pending Approvals';
      case 3:
        return 'Supervisor Allocation';
      case 4:
        return 'Companies';
      case 5:
        return 'Pending Placements';
      default:
        return 'Admin Dashboard';
    }
  }

  Widget _buildBody(int tab) {
    switch (tab) {
      case 0:
        return const OverviewPage();
      case 1:
        return const UsersManagementPage();
      case 2:
        return const PendingApprovalsPage();
      case 3:
        return const SupervisorAllocationPage();
      case 4:
        return const CompaniesManagementPage();
      case 5:
        return const PendingPlacementsPage();
      default:
        return const OverviewPage();
    }
  }
}

// ============================================================================
// ADMIN NAVIGATION DRAWER
// ============================================================================

class _AdminDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedAdminTabProvider);
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  MustBrandColors.green,
                  MustBrandColors.greenLight,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: MustBrandColors.gold, width: 1.5),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/icons/must logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.admin_panel_settings,
                      size: 34,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Admin Panel',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'DIMS Management',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Navigation Items
          _DrawerItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            isSelected: selectedTab == 0,
            onTap: () {
              ref.read(selectedAdminTabProvider.notifier).state = 0;
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.people,
            title: 'User Management',
            isSelected: selectedTab == 1,
            onTap: () {
              ref.read(selectedAdminTabProvider.notifier).state = 1;
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.approval,
            title: 'Pending Approvals',
            isSelected: selectedTab == 2,
            badge: _getPendingApprovalsCount(ref),
            onTap: () {
              ref.read(selectedAdminTabProvider.notifier).state = 2;
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.assignment_ind,
            title: 'Supervisor Allocation',
            isSelected: selectedTab == 3,
            onTap: () {
              ref.read(selectedAdminTabProvider.notifier).state = 3;
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.business,
            title: 'Companies',
            isSelected: selectedTab == 4,
            onTap: () {
              ref.read(selectedAdminTabProvider.notifier).state = 4;
              Navigator.pop(context);
            },
          ),
          _DrawerItem(
            icon: Icons.pending_actions,
            title: 'Pending Placements',
            isSelected: selectedTab == 5,
            badge: _getPendingPlacementsCount(ref),
            onTap: () {
              ref.read(selectedAdminTabProvider.notifier).state = 5;
              Navigator.pop(context);
            },
          ),

          const Divider(),

          // Settings & Logout
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              Navigator.pop(context);
              await ref.read(authControllerProvider).signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
    );
  }

  int? _getPendingApprovalsCount(WidgetRef ref) {
    // TODO: Add provider to count pending approvals
    return null;
  }

  int? _getPendingPlacementsCount(WidgetRef ref) {
    // TODO: Add provider to count pending placements
    return null;
  }
}

// ============================================================================
// DRAWER ITEM WIDGET
// ============================================================================

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final int? badge;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? theme.colorScheme.primary : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? theme.colorScheme.primary : null,
        ),
      ),
      trailing: badge != null && badge! > 0
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primary.withOpacity(0.1),
      onTap: onTap,
    );
  }
}
