import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/home_entities.dart';

class HealthStatsCard extends StatelessWidget {
  final HealthSummary healthSummary;

  const HealthStatsCard({super.key, required this.healthSummary});

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
          _StatItem(
            icon: Icons.favorite,
            iconColor: AppColors.error,
            label: 'Heart Rate',
            value: healthSummary.latestHeartRate ?? '—',
          ),
          _divider(),
          _StatItem(
            icon: Icons.bloodtype,
            iconColor: AppColors.secondary,
            label: 'Blood Pressure',
            value: healthSummary.latestBloodPressure ?? '—',
          ),
          _divider(),
          _StatItem(
            icon: Icons.description_outlined,
            iconColor: AppColors.primary,
            label: 'Records',
            value: '${healthSummary.medicalRecordsCount}',
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

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatItem({
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
          Text(
            value,
            style: AppTextStyles.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: AppColors.textHint),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
