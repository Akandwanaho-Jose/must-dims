import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../results/final_marks_model.dart';
import '../../controllers/final_marks_controller.dart';

class FinalMarksResultsPage extends ConsumerStatefulWidget {
  const FinalMarksResultsPage({super.key});

  @override
  ConsumerState<FinalMarksResultsPage> createState() =>
      _FinalMarksResultsPageState();
}

class _FinalMarksResultsPageState extends ConsumerState<FinalMarksResultsPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _programFilter = 'All programs';
  String _supervisorFilter = 'All supervisors';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final marksAsync = ref.watch(finalMarksProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(finalMarksProvider),
        child: marksAsync.when(
          data: (records) => _buildContent(context, records),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('Unable to load final marks: $error'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<FinalMarksModel> records) {
    final theme = Theme.of(context);
    final programs = [
      'All programs',
      ...records.map((record) => record.program).toSet().toList()..sort(),
    ];
    final supervisors = [
      'All supervisors',
      ...records.map((record) => record.supervisorName).toSet().toList()
        ..sort(),
    ];
    final filteredRecords = _filter(records);
    final average = filteredRecords.isEmpty
        ? 0.0
        : filteredRecords
                .map((record) => record.totalMarks)
                .reduce((left, right) => left + right) /
            filteredRecords.length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Final Marks',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Retrieve and filter student final results.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _SummaryTile(
              label: 'Students marked',
              value: '${filteredRecords.length}',
              icon: Icons.fact_check_outlined,
            ),
            _SummaryTile(
              label: 'Average total',
              value: _formatMarks(average),
              icon: Icons.analytics_outlined,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search student, registration number, program',
                    prefixIcon: Icon(Icons.search_rounded),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(
                    () => _searchQuery = value.trim().toLowerCase(),
                  ),
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 720;
                    final fields = [
                      _FilterDropdown(
                        value: programs.contains(_programFilter)
                            ? _programFilter
                            : 'All programs',
                        items: programs,
                        label: 'Program',
                        onChanged: (value) => setState(
                          () => _programFilter = value ?? 'All programs',
                        ),
                      ),
                      _FilterDropdown(
                        value: supervisors.contains(_supervisorFilter)
                            ? _supervisorFilter
                            : 'All supervisors',
                        items: supervisors,
                        label: 'Supervisor',
                        onChanged: (value) => setState(
                          () => _supervisorFilter = value ?? 'All supervisors',
                        ),
                      ),
                    ];

                    if (compact) {
                      return Column(
                        children: [
                          fields[0],
                          const SizedBox(height: 12),
                          fields[1],
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(child: fields[0]),
                        const SizedBox(width: 12),
                        Expanded(child: fields[1]),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _MarksTable(records: filteredRecords),
      ],
    );
  }

  List<FinalMarksModel> _filter(List<FinalMarksModel> records) {
    return records.where((record) {
      final matchesSearch = _searchQuery.isEmpty ||
          [
            record.studentName,
            record.registrationNumber,
            record.program,
            record.supervisorName,
          ].join(' ').toLowerCase().contains(_searchQuery);
      final matchesProgram =
          _programFilter == 'All programs' || record.program == _programFilter;
      final matchesSupervisor = _supervisorFilter == 'All supervisors' ||
          record.supervisorName == _supervisorFilter;

      return matchesSearch && matchesProgram && matchesSupervisor;
    }).toList();
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final String label;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _MarksTable extends StatelessWidget {
  const _MarksTable({required this.records});

  final List<FinalMarksModel> records;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (records.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Center(
            child: Text(
              'No final marks match the current filters.',
              style: theme.textTheme.titleSmall,
            ),
          ),
        ),
      );
    }

    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 24,
            headingRowColor: WidgetStatePropertyAll(
              theme.colorScheme.primaryContainer.withOpacity(0.35),
            ),
            columns: const [
              DataColumn(label: Text('Student')),
              DataColumn(label: Text('Reg No.')),
              DataColumn(label: Text('Program')),
              DataColumn(label: Text('First Visit')),
              DataColumn(label: Text('Second Visit')),
              DataColumn(label: Text('Company')),
              DataColumn(label: Text('Total')),
              DataColumn(label: Text('Supervisor')),
            ],
            rows: records
                .map(
                  (record) => DataRow(
                    cells: [
                      DataCell(Text(record.studentName)),
                      DataCell(Text(record.registrationNumber)),
                      DataCell(Text(record.program)),
                      DataCell(Text(_formatMarks(record.firstVisitMarks))),
                      DataCell(Text(_formatMarks(record.secondVisitMarks))),
                      DataCell(
                        Text(_formatMarks(record.companySupervisorMarks)),
                      ),
                      DataCell(
                        Text(
                          _formatMarks(record.totalMarks),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      DataCell(Text(record.supervisorName)),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

String _formatMarks(double value) {
  return value == value.truncateToDouble()
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
}
