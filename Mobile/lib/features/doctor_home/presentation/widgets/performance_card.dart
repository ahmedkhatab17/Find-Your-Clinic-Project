import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/doctor_dashboard_entities.dart';

class PerformanceCard extends StatelessWidget {
  final PerformanceSummary performance;

  const PerformanceCard({super.key, required this.performance});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _PerformanceItem(
            icon: Icons.people,
            iconColor: AppColors.primary,
            label: 'Patients',
            value: '${performance.totalPatients}',
          ),
          _divider(),
          _PerformanceItem(
            icon: Icons.star,
            iconColor: AppColors.starRating,
            label: 'Avg. Rating',
            value: performance.averageRating.toStringAsFixed(1),
          ),
          _divider(),
          _PerformanceItem(
            icon: Icons.rate_review,
            iconColor: AppColors.secondary,
            label: 'Reviews',
            value: '${performance.totalReviews}',
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 40,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: AppColors.divider,
    );
  }
}

class _PerformanceItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _PerformanceItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.label),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: AppColors.textHint),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
