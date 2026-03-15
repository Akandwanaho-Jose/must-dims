import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../companies/data/models/company_model.dart';

// Provider for companies list
final companiesProvider = StreamProvider<List<CompanyModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('companies')
      .orderBy('name')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs
            .map((doc) => CompanyModel.fromFirestore(doc, null))
            .toList();
      });
});

class CompaniesManagementPage extends ConsumerWidget {
  const CompaniesManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesAsync = ref.watch(companiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddEditDialog(context, ref),
            tooltip: 'Add Company',
          ),
        ],
      ),
      body: companiesAsync.when(
        data: (companies) {
          if (companies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.business, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No companies yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text('Add your first company to get started'),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _showAddEditDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Company'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: company.isActive ? Colors.green : Colors.grey,
                    child: Text(
                      company.name[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    company.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${company.industry} • ${company.location}'),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${company.currentInterns}/${company.maxInterns == 0 ? '∞' : company.maxInterns} interns',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            company.acceptingInterns
                                ? Icons.check_circle
                                : Icons.cancel,
                            size: 14,
                            color: company.acceptingInterns
                                ? Colors.green
                                : Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            company.acceptingInterns ? 'Accepting' : 'Not accepting',
                            style: TextStyle(
                              fontSize: 12,
                              color: company.acceptingInterns
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'toggle',
                        child: Row(
                          children: [
                            Icon(
                              company.isActive ? Icons.block : Icons.check_circle,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(company.isActive ? 'Deactivate' : 'Activate'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _showAddEditDialog(context, ref, company: company);
                          break;
                        case 'toggle':
                          _toggleCompanyStatus(context, ref, company);
                          break;
                        case 'delete':
                          _deleteCompany(context, ref, company);
                          break;
                      }
                    },
                  ),
                  onTap: () => _showCompanyDetails(context, company),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  void _showAddEditDialog(
    BuildContext context,
    WidgetRef ref, {
    CompanyModel? company,
  }) {
    showDialog(
      context: context,
      builder: (context) => _CompanyFormDialog(company: company),
    );
  }

  void _showCompanyDetails(BuildContext context, CompanyModel company) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(company.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _DetailRow('Industry', company.industry),
              _DetailRow('Location', company.location),
              if (company.contactEmail != null)
                _DetailRow('Email', company.contactEmail!),
              if (company.contactPhone != null)
                _DetailRow('Phone', company.contactPhone!),
              if (company.website != null)
                _DetailRow('Website', company.website!),
              if (company.description != null) ...[
                const SizedBox(height: 8),
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(company.description!),
              ],
              const SizedBox(height: 8),
              _DetailRow(
                'Max Interns',
                company.maxInterns == 0 ? 'Unlimited' : company.maxInterns.toString(),
              ),
              _DetailRow('Current Interns', company.currentInterns.toString()),
              if (company.preferredPrograms.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text(
                  'Preferred Programs',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: company.preferredPrograms
                      .map((program) => Chip(
                            label: Text(program, style: const TextStyle(fontSize: 12)),
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleCompanyStatus(
    BuildContext context,
    WidgetRef ref,
    CompanyModel company,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('companies')
          .doc(company.id)
          .update({
        'isActive': !company.isActive,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              company.isActive
                  ? 'Company deactivated'
                  : 'Company activated',
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteCompany(
    BuildContext context,
    WidgetRef ref,
    CompanyModel company,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Company?'),
        content: Text(
          'Are you sure you want to delete "${company.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await FirebaseFirestore.instance
          .collection('companies')
          .doc(company.id)
          .delete();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Company deleted')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

// ── Company Form Dialog ──────────────────────────────────────────────────────

class _CompanyFormDialog extends StatefulWidget {
  final CompanyModel? company;

  const _CompanyFormDialog({this.company});

  @override
  State<_CompanyFormDialog> createState() => _CompanyFormDialogState();
}

class _CompanyFormDialogState extends State<_CompanyFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _industryController;
  late TextEditingController _locationController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _websiteController;
  late TextEditingController _descriptionController;
  late TextEditingController _maxInternsController;

  bool _isLoading = false;
  bool _acceptingInterns = true;

  final List<String> _availablePrograms = [
    'Computer Science',
    'Information Technology',
    'Software Engineering',
    'Data Science',
    'Cyber Security',
    'Business Administration',
    'Accounting',
    'Marketing',
  ];

  List<String> _selectedPrograms = [];

  @override
  void initState() {
    super.initState();
    final company = widget.company;

    _nameController = TextEditingController(text: company?.name);
    _industryController = TextEditingController(text: company?.industry);
    _locationController = TextEditingController(text: company?.location);
    _emailController = TextEditingController(text: company?.contactEmail);
    _phoneController = TextEditingController(text: company?.contactPhone);
    _websiteController = TextEditingController(text: company?.website);
    _descriptionController = TextEditingController(text: company?.description);
    _maxInternsController = TextEditingController(
      text: company?.maxInterns == 0 ? '' : company?.maxInterns.toString(),
    );

    _acceptingInterns = company?.acceptingInterns ?? true;
    _selectedPrograms = company?.preferredPrograms ?? [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _industryController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    _maxInternsController.dispose();
    super.dispose();
  }

  Future<void> _saveCompany() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final maxInterns = _maxInternsController.text.trim().isEmpty
          ? 0
          : int.tryParse(_maxInternsController.text.trim()) ?? 0;

      final data = {
        'name': _nameController.text.trim(),
        'industry': _industryController.text.trim(),
        'location': _locationController.text.trim(),
        'contactEmail': _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
        'contactPhone': _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        'website': _websiteController.text.trim().isEmpty
            ? null
            : _websiteController.text.trim(),
        'description': _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        'maxInterns': maxInterns,
        'acceptingInterns': _acceptingInterns,
        'preferredPrograms': _selectedPrograms,
        'isActive': true,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (widget.company == null) {
        // Create new
        data['currentInterns'] = 0;
        data['companySupervisorIds'] = [];
        data['createdAt'] = FieldValue.serverTimestamp();

        await FirebaseFirestore.instance.collection('companies').add(data);

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Company added successfully')),
          );
        }
      } else {
        // Update existing
        await FirebaseFirestore.instance
            .collection('companies')
            .doc(widget.company!.id)
            .update(data);

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Company updated successfully')),
          );
        }
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
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.company == null ? 'Add Company' : 'Edit Company';

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 540,
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
                      onPressed: _isLoading ? null : () => Navigator.pop(context),
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
                            labelText: 'Company Name *',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _industryController,
                          decoration: const InputDecoration(
                            labelText: 'Industry *',
                            hintText: 'e.g., Technology, Finance, Healthcare',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                            labelText: 'Location *',
                            hintText: 'e.g., Kampala, Mbarara',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Contact Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Contact Phone',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _websiteController,
                          decoration: const InputDecoration(
                            labelText: 'Website',
                            hintText: 'https://example.com',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.url,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _maxInternsController,
                          decoration: const InputDecoration(
                            labelText: 'Max Interns (0 = unlimited)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text('Accepting Interns'),
                          value: _acceptingInterns,
                          onChanged: (value) {
                            setState(() => _acceptingInterns = value);
                          },
                        ),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Preferred Programs',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _availablePrograms.map((program) {
                            final isSelected = _selectedPrograms.contains(program);
                            return FilterChip(
                              label: Text(program),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedPrograms.add(program);
                                  } else {
                                    _selectedPrograms.remove(program);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
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
                            onPressed: _isLoading ? null : _saveCompany,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Text(widget.company == null ? 'Add Company' : 'Save'),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            onPressed:
                                _isLoading ? null : () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        OutlinedButton(
                          onPressed:
                              _isLoading ? null : () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: _isLoading ? null : _saveCompany,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text(widget.company == null ? 'Add Company' : 'Save'),
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
}
