import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/locale/l10n_extension.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../accessibility/domain/entities/screen_context.dart';
import '../../../accessibility/presentation/cubits/voice_assistant_cubit.dart';
import '../../domain/entities/health_record_entity.dart';
import '../cubits/health_record_cubit.dart';
import '../cubits/health_record_state.dart';
import '../widgets/allergy_alert_banner.dart';
import '../widgets/category_tabs.dart';
import '../widgets/empty_records_view.dart';
import '../widgets/record_list_tile.dart';
import '../widgets/vital_card.dart';

// TASK 2.4 — Date filter enum (client-side, no API call)
enum _DateFilter { thisMonth, last3Months, thisYear, all }

class HealthRecordsScreen extends StatefulWidget {
  const HealthRecordsScreen({super.key});

  @override
  State<HealthRecordsScreen> createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> {
  _DateFilter _dateFilter = _DateFilter.all;
  static const _screenContext = ScreenContext(screen: PatientScreen.healthRecords);

  @override
  void initState() {
    super.initState();
    context.read<HealthRecordCubit>().loadRecords();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<VoiceAssistantCubit>().setScreenContext(
            _screenContext,
            summary: _buildScreenSummary,
            itemSelector: _itemSelector,
          );
    });
  }

  String _buildScreenSummary() {
    final state = context.read<HealthRecordCubit>().state;
    if (state is HealthRecordListLoaded) {
      final records = _applyDateFilter(state.records);
      if (records.isEmpty) return context.l10n.noResults;
      final buffer = StringBuffer('You have ${records.length} health records. ');
      final readN = records.length > 3 ? 3 : records.length;
      for (var i = 0; i < readN; i++) {
        final r = records[i];
        final date = DateFormat.yMMMd(Localizations.localeOf(context).languageCode).format(r.recordedAt);
        buffer.write('${i + 1}: ${r.title} on $date. ');
      }
      return buffer.toString();
    }
    return context.l10n.healthRecordsTitle;
  }

  bool _itemSelector(int index) {
    final state = context.read<HealthRecordCubit>().state;
    if (state is! HealthRecordListLoaded) return false;
    final records = _applyDateFilter(state.records);
    if (index < 0 || index >= records.length) return false;
    // No detail screen exists yet, so just do nothing or maybe read the record's details aloud.
    // For now, returning true so it acknowledges the selection.
    return true;
  }
  VitalEntity? _vitalFor(HealthSummaryEntity summary, String key) =>
      switch (key) {
        'bloodPressure' => summary.bloodPressure,
        'heartRate' => summary.heartRate,
        'bloodSugar' => summary.bloodSugar,
        'temperature' => summary.temperature,
        'weight' => summary.weight,
        'spO2' => summary.spO2,
        _ => null,
      };

  List<HealthRecordEntity> _applyDateFilter(List<HealthRecordEntity> records) {
    final now = DateTime.now();
    return records.where((r) {
      return switch (_dateFilter) {
        _DateFilter.thisMonth => r.recordedAt.isAfter(
          now.subtract(const Duration(days: 30)),
        ),
        _DateFilter.last3Months => r.recordedAt.isAfter(
          now.subtract(const Duration(days: 90)),
        ),
        _DateFilter.thisYear => r.recordedAt.year == now.year,
        _DateFilter.all => true,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final vitalMeta = [
      (
        key: 'bloodPressure',
        label: context.l10n.typeBloodPressure,
        icon: Icons.favorite_outline,
        color: Colors.red,
      ),
      (
        key: 'heartRate',
        label: context.l10n.typeHeartRate,
        icon: Icons.monitor_heart_outlined,
        color: Colors.pink,
      ),
      (
        key: 'bloodSugar',
        label: context.l10n.typeBloodSugar,
        icon: Icons.water_drop_outlined,
        color: Colors.orange,
      ),
      (
        key: 'temperature',
        label: context.l10n.typeTemperature,
        icon: Icons.thermostat_outlined,
        color: Colors.amber,
      ),
      (
        key: 'weight',
        label: context.l10n.typeWeight,
        icon: Icons.fitness_center_outlined,
        color: Colors.green,
      ),
      (key: 'spO2', label: context.l10n.typeSpO2, icon: Icons.air_outlined, color: Colors.blue),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.healthRecordsTitle,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 80,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? AppTheme.headerGradientDark
                : AppTheme.headerGradient,
          ),
        ),
      ),
      // TASK 1.6 — Persistent bottom bar instead of FAB
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: FilledButton.icon(
            onPressed: () async {
              await context.pushNamed(RouteNames.addHealthRecord);
              if (context.mounted) {
                context.read<HealthRecordCubit>().loadRecords();
              }
            },
            icon: const Icon(Icons.add),
            label: Text(context.l10n.addNewRecord),
          ),
        ),
      ),
      body: BlocConsumer<HealthRecordCubit, HealthRecordState>(
        listener: (context, state) {
          if (state is HealthRecordActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is HealthRecordLoading || state is HealthRecordInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HealthRecordError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () =>
                        context.read<HealthRecordCubit>().loadRecords(),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            );
          }

          if (state is HealthRecordListLoaded) {
            final allergies = state.records
                .where((r) => r.type == HealthRecordType.allergy)
                .toList();
            final filtered = _applyDateFilter(state.records);

            return RefreshIndicator(
              onRefresh: () => context.read<HealthRecordCubit>().loadRecords(
                type: state.activeFilter,
              ),
              child: CustomScrollView(
                slivers: [
                  // TASK 1.5 — Allergy alert banner (always first)
                  SliverToBoxAdapter(
                    child: AllergyAlertBanner(allergies: allergies),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
                      child: Text(
                        context.l10n.vitalsSummary,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 130,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: vitalMeta
                            .map(
                              (m) => VitalCard(
                                label: m.label,
                                vital: _vitalFor(state.summary, m.key),
                                icon: m.icon,
                                color: m.color,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  SliverToBoxAdapter(
                    child: CategoryTabs(
                      activeFilter: state.activeFilter,
                      onFilterChanged: (type) => context
                          .read<HealthRecordCubit>()
                          .loadRecords(type: type),
                    ),
                  ),

                  // TASK 2.4 — Date filter chips (client-side)
                  SliverToBoxAdapter(
                    child: _DateFilterBar(
                      current: _dateFilter,
                      onChanged: (f) => setState(() => _dateFilter = f),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 8)),
                  if (filtered.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyRecordsView(),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final record = filtered[index];
                        // TASK 2.5 — Semantic labels for accessibility
                        return Semantics(
                          label: context.l10n.healthRecordSemanticLabel(
                            record.title,
                            record.type.name,
                            DateFormat('MMMM d, y').format(record.recordedAt.toLocal()),
                          ),
                          child: RecordListTile(
                            record: record,
                            onTap: () => context.pushNamed(
                              RouteNames.healthRecordDetail,
                              pathParameters: {'id': record.id},
                            ),
                            onDelete: () => context
                                .read<HealthRecordCubit>()
                                .deleteRecord(record.id),
                          ),
                        );
                      }, childCount: filtered.length),
                    ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ─── Date Filter Bar ───
class _DateFilterBar extends StatelessWidget {
  final _DateFilter current;
  final ValueChanged<_DateFilter> onChanged;

  const _DateFilterBar({required this.current, required this.onChanged});

  static final _options = <(_DateFilter, String Function(BuildContext))>[
    (_DateFilter.thisMonth, (context) => context.l10n.thisMonth),
    (_DateFilter.last3Months, (context) => context.l10n.last3Months),
    (_DateFilter.thisYear, (context) => context.l10n.thisYear),
    (_DateFilter.all, (context) => context.l10n.allTime),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: _options.map((opt) {
          final isSelected = current == opt.$1;
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: FilterChip(
              label: Text(opt.$2(context)),
              selected: isSelected,
              onSelected: (_) => onChanged(opt.$1),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }
}
