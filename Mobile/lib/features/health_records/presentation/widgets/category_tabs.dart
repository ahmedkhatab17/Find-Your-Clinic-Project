import 'package:flutter/material.dart';

import '../../../../core/locale/l10n_extension.dart';
import '../../domain/entities/health_record_entity.dart';

class CategoryTabs extends StatelessWidget {
  final HealthRecordType? activeFilter;
  final ValueChanged<HealthRecordType?> onFilterChanged;

  const CategoryTabs({
    super.key,
    required this.activeFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = <(HealthRecordType?, String)>[
      (null, context.l10n.categoryAll),
      (HealthRecordType.bloodTest, context.l10n.categoryBloodTests),
      (HealthRecordType.radiology, context.l10n.categoryRadiology),
      (HealthRecordType.prescription, context.l10n.categoryPrescriptions),
      (HealthRecordType.bloodPressure, context.l10n.categoryVitals),
      (HealthRecordType.labResult, context.l10n.categoryLabResults),
      (HealthRecordType.vaccination, context.l10n.categoryVaccination),
      (HealthRecordType.other, context.l10n.categoryOther),
    ];

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: tabs.map((entry) {
          final isSelected = activeFilter == entry.$1;
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 8),
            child: FilterChip(
              label: Text(entry.$2),
              selected: isSelected,
              onSelected: (_) => onFilterChanged(entry.$1),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }
}
