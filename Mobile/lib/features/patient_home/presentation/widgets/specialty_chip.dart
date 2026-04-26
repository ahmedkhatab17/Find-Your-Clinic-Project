import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SpecialtyChip extends StatelessWidget {
  final String name;
  final String? iconUrl;
  final VoidCallback? onTap;

  const SpecialtyChip({
    super.key,
    required this.name,
    this.iconUrl,
    this.onTap,
  });

  IconData get _fallbackIcon {
    final lower = name.toLowerCase();
    if (lower.contains('cardio') || lower.contains('heart')) return Icons.favorite;
    if (lower.contains('derma') || lower.contains('skin')) return Icons.face;
    if (lower.contains('neuro') || lower.contains('brain')) return Icons.psychology;
    if (lower.contains('ortho') || lower.contains('bone')) return Icons.accessibility_new;
    if (lower.contains('pediatr') || lower.contains('child')) return Icons.child_care;
    if (lower.contains('dental') || lower.contains('dent')) return Icons.mood;
    if (lower.contains('eye') || lower.contains('ophthal')) return Icons.visibility;
    if (lower.contains('ent') || lower.contains('ear')) return Icons.hearing;
    if (lower.contains('general')) return Icons.local_hospital;
    return Icons.medical_services;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceAlt
                    : AppColors.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _fallbackIcon,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: AppTextStyles.labelSm,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
