import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/doctor_search_entities.dart';

class FilterBottomSheet extends StatefulWidget {
  final SearchFilters currentFilters;
  final void Function(SearchFilters) onApply;

  const FilterBottomSheet({
    super.key,
    required this.currentFilters,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late double _minRating;
  late RangeValues _feeRange;
  late String _sortBy;

  @override
  void initState() {
    super.initState();
    _minRating = widget.currentFilters.minRating ?? 0;
    _feeRange = RangeValues(
      widget.currentFilters.minFee ?? 0,
      widget.currentFilters.maxFee ?? 500,
    );
    _sortBy = widget.currentFilters.sortBy ?? 'rating';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Filters', style: AppTextStyles.heading2),
          const SizedBox(height: 20),

          // ─── Sort By ───
          Text('Sort By', style: AppTextStyles.label),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _SortChip(
                label: 'Rating',
                selected: _sortBy == 'rating',
                onTap: () => setState(() => _sortBy = 'rating'),
              ),
              _SortChip(
                label: 'Fee (Low)',
                selected: _sortBy == 'fee_asc',
                onTap: () => setState(() => _sortBy = 'fee_asc'),
              ),
              _SortChip(
                label: 'Fee (High)',
                selected: _sortBy == 'fee_desc',
                onTap: () => setState(() => _sortBy = 'fee_desc'),
              ),
              _SortChip(
                label: 'Experience',
                selected: _sortBy == 'experience',
                onTap: () => setState(() => _sortBy = 'experience'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ─── Min Rating ───
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Minimum Rating', style: AppTextStyles.label),
              Text(
                _minRating == 0 ? 'Any' : '${_minRating.toStringAsFixed(1)}+',
                style: AppTextStyles.label.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          Slider(
            value: _minRating,
            min: 0,
            max: 5,
            divisions: 10,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _minRating = v),
          ),
          const SizedBox(height: 12),

          // ─── Fee Range ───
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fee Range', style: AppTextStyles.label),
              Text(
                '\$${_feeRange.start.toInt()} — \$${_feeRange.end.toInt()}',
                style: AppTextStyles.label.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          RangeSlider(
            values: _feeRange,
            min: 0,
            max: 500,
            divisions: 50,
            activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _feeRange = v),
          ),
          const SizedBox(height: 24),

          // ─── Apply Button ───
          SizedBox(
            width: double.infinity,
            child: AppButton(
              text: 'Apply Filters',
              onPressed: () {
                widget.onApply(SearchFilters(
                  specialtyId: widget.currentFilters.specialtyId,
                  minRating: _minRating > 0 ? _minRating : null,
                  minFee: _feeRange.start > 0 ? _feeRange.start : null,
                  maxFee: _feeRange.end < 500 ? _feeRange.end : null,
                  sortBy: _sortBy,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SortChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: AppTextStyles.labelSm.copyWith(
            color: selected ? Colors.white : AppColors.textPrimary,
          ),
        ),
        backgroundColor: selected ? AppColors.primary : AppColors.surfaceAlt,
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.divider,
        ),
      ),
    );
  }
}
