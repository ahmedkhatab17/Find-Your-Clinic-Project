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

    if (lower.contains('cardio') || lower.contains('heart')) {
      return Icons.favorite; // Cardiology
    }
    if (lower.contains('derma') || lower.contains('skin')) {
      return Icons.face; // Dermatology
    }
    if (lower.contains('neuro') || lower.contains('brain')) {
      return Icons.psychology; // Neurology
    }
    if (lower.contains('ortho') || lower.contains('bone')) {
      return Icons.accessibility_new; // Orthopedics
    }
    if (lower.contains('pediatr') || lower.contains('child')) {
      return Icons.child_care; // Pediatrics
    }
    if (lower.contains('dent')) {
      return Icons.mood; // Dentistry
    }
    if (lower.contains('eye') || lower.contains('ophthal')) {
      return Icons.visibility; // Ophthalmology
    }
    if (lower.contains('ent') || lower.contains('ear')) {
      return Icons.hearing; // ENT
    }
    if (lower.contains('psych') || lower.contains('mental')) {
      return Icons.psychology_alt; // Psychiatry
    }
    if (lower.contains('radio') ||
        lower.contains('scan') ||
        lower.contains('xray')) {
      return Icons.medical_information; // Radiology
    }
    if (lower.contains('onco') || lower.contains('cancer')) {
      return Icons.healing; // Oncology
    }
    if (lower.contains('uro') || lower.contains('urinary')) {
      return Icons.water_drop; // Urology
    }
    if (lower.contains('nephro') || lower.contains('kidney')) {
      return Icons.bloodtype; // Nephrology
    }
    if (lower.contains('gastro') || lower.contains('stomach')) {
      return Icons.lunch_dining; // Gastroenterology
    }
    if (lower.contains('endo') || lower.contains('hormone')) {
      return Icons.science; // Endocrinology
    }
    if (lower.contains('pulmo') || lower.contains('lung')) {
      return Icons.air; // Pulmonology
    }
    if (lower.contains('hema') || lower.contains('blood')) {
      return Icons.bloodtype; // Hematology
    }
    if (lower.contains('rheuma') || lower.contains('joint')) {
      return Icons.accessibility; // Rheumatology
    }
    if (lower.contains('infect') || lower.contains('virus')) {
      return Icons.coronavirus; // Infectious Diseases
    }
    if (lower.contains('anesth')) {
      return Icons.bed; // Anesthesiology
    }
    if (lower.contains('emergency') || lower.contains('er')) {
      return Icons.emergency; // Emergency Medicine
    }
    if (lower.contains('gyne') ||
        lower.contains('obstetric') ||
        lower.contains('pregnan')) {
      return Icons.pregnant_woman; // Obstetrics & Gynecology
    }
    if (lower.contains('surgery') || lower.contains('surgeon')) {
      return Icons.content_cut; // Surgery
    }
    if (lower.contains('plastic') || lower.contains('cosmetic')) {
      return Icons.face_retouching_natural; // Plastic Surgery
    }
    if (lower.contains('vascular')) {
      return Icons.monitor_heart; // Vascular
    }
    if (lower.contains('therapy') || lower.contains('physio')) {
      return Icons.fitness_center; // Physical Therapy
    }
    if (lower.contains('sports')) {
      return Icons.sports_soccer; // Sports Medicine
    }
    if (lower.contains('allergy') || lower.contains('immun')) {
      return Icons.grass; // Allergy & Immunology
    }
    if (lower.contains('geriatric') || lower.contains('elder')) {
      return Icons.elderly; // Geriatrics
    }
    if (lower.contains('patho') || lower.contains('lab')) {
      return Icons.biotech; // Pathology
    }
    if (lower.contains('pain')) {
      return Icons.sick; // Pain Management
    }
    if (lower.contains('critical') || lower.contains('icu')) {
      return Icons.monitor; // Critical Care
    }
    if (lower.contains('general')) {
      return Icons.local_hospital; // General Medicine
    }

    return Icons.medical_services;
  }

  String _getLocalizedName(BuildContext context) {
    final lower = name.toLowerCase();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    if (!isArabic) return name;

    if (lower.contains('cardio') || lower.contains('heart')) return 'قلب';
    if (lower.contains('derma') || lower.contains('skin')) return 'جلدية';
    if (lower.contains('neuro') || lower.contains('brain')) return 'أعصاب';
    if (lower.contains('ortho') || lower.contains('bone')) return 'عظام';
    if (lower.contains('pediatr') || lower.contains('child')) return 'أطفال';
    if (lower.contains('dent')) return 'أسنان';
    if (lower.contains('eye') || lower.contains('ophthal')) return 'عيون';
    if (lower.contains('ent') || lower.contains('ear')) {
      return 'أنف وأذن وحنجرة';
    }
    if (lower.contains('psych') || lower.contains('mental')) return 'نفسية';
    if (lower.contains('radio') || lower.contains('scan') || lower.contains('xray')) {
      return 'أشعة';
    }
    if (lower.contains('onco') || lower.contains('cancer')) return 'أورام';
    if (lower.contains('uro') || lower.contains('urinary')) {
      return 'مسالك بولية';
    }
    if (lower.contains('nephro') || lower.contains('kidney')) return 'كلى';
    if (lower.contains('gastro') || lower.contains('stomach')) {
      return 'جهاز هضمي';
    }
    if (lower.contains('endo') || lower.contains('hormone')) return 'غدد صماء';
    if (lower.contains('pulmo') || lower.contains('lung')) return 'صدرية';
    if (lower.contains('hema') || lower.contains('blood')) return 'دم';
    if (lower.contains('rheuma') || lower.contains('joint')) return 'روماتيزم';
    if (lower.contains('infect') || lower.contains('virus')) {
      return 'أمراض معدية';
    }
    if (lower.contains('anesth')) return 'تخدير';
    if (lower.contains('emergency') || lower.contains('er')) return 'طوارئ';
    if (lower.contains('gyne') || lower.contains('obstetric') || lower.contains('pregnan')) {
      return 'نساء وتوليد';
    }
    if (lower.contains('surgery') || lower.contains('surgeon')) return 'جراحة';
    if (lower.contains('plastic') || lower.contains('cosmetic')) return 'تجميل';
    if (lower.contains('vascular')) return 'أوعية دموية';
    if (lower.contains('therapy') || lower.contains('physio')) {
      return 'علاج طبيعي';
    }
    if (lower.contains('sports')) return 'طب رياضي';
    if (lower.contains('allergy') || lower.contains('immun')) {
      return 'حساسية ومناعة';
    }
    if (lower.contains('geriatric') || lower.contains('elder')) {
      return 'طب المسنين';
    }
    if (lower.contains('patho') || lower.contains('lab')) return 'تحاليل طبية';
    if (lower.contains('pain')) return 'علاج الألم';
    if (lower.contains('critical') || lower.contains('icu')) {
      return 'رعاية مركزة';
    }
    if (lower.contains('general')) return 'باطنة عامة';

    return name;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final displayName = _getLocalizedName(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(bottom: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceAlt
                    : AppColors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.primary.withValues(alpha: 0.05),
                  width: 1,
                ),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Icon(_fallbackIcon, color: AppColors.primary, size: 28),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                displayName,
                style: AppTextStyles.labelSm.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  letterSpacing: -0.2,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.9)
                      : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
