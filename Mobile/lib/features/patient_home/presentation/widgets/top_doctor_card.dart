import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/home_entities.dart';

class TopDoctorCard extends StatelessWidget {
  final TopDoctor doctor;
  final VoidCallback? onTap;

  const TopDoctorCard({super.key, required this.doctor, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary.withAlpha(20),
              child: const Icon(Icons.person, color: AppColors.primary, size: 32),
            ),
            const SizedBox(height: 10),
            // Name
            Text(
              'Dr. ${doctor.fullName}',
              style: AppTextStyles.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            // Specialty
            Text(
              doctor.specialty,
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            // Rating + fee
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: AppColors.starRating, size: 14),
                const SizedBox(width: 3),
                Text(
                  doctor.rating.toStringAsFixed(1),
                  style: AppTextStyles.labelSm,
                ),
                const SizedBox(width: 6),
                Text(
                  '·',
                  style: AppTextStyles.bodySm.copyWith(color: AppColors.textHint),
                ),
                const SizedBox(width: 6),
                Text(
                  '\$${doctor.consultationFee.toStringAsFixed(0)}',
                  style: AppTextStyles.labelSm.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
