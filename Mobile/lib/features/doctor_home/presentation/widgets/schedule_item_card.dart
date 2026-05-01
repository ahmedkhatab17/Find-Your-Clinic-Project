import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../domain/entities/doctor_dashboard_entities.dart';

class ScheduleItemCard extends StatelessWidget {
  final ScheduleItem item;

  const ScheduleItemCard({super.key, required this.item});

  Color get _statusColor {
    switch (item.status.toLowerCase()) {
      case 'confirmed':
        return AppColors.success;
      case 'completed':
        return AppColors.info;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final timeStr = DateFormat('h:mm a').format(item.scheduledAt);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Time pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              timeStr,
              style: AppTextStyles.labelSm.copyWith(color: AppColors.primary),
            ),
          ),
          const SizedBox(width: 12),
          // Patient info
          UserAvatar(
            radius: 18,
            imageUrl: item.patientImageUrl,
            fullName: item.patientName,
            backgroundColor: AppColors.primary.withAlpha(20),
            textStyle: AppTextStyles.labelSm.copyWith(color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.patientName,
              style: AppTextStyles.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _statusColor.withAlpha(80)),
            ),
            child: Text(
              item.status,
              style: AppTextStyles.caption.copyWith(color: _statusColor),
            ),
          ),
        ],
      ),
    );
  }
}
