import 'package:flutter/widgets.dart';

extension DoctorNameExtension on String {
  /// Ensures the name has exactly one 'Dr. ' prefix.
  String get withDoctorPrefix {
    final regex = RegExp(r'^(dr\.|dr\s+|doctor\s+)+', caseSensitive: false);
    final noPrefix = replaceAll(regex, '').trim();
    return 'Dr. $noPrefix';
  }

  /// Translates common English medical specialties to Arabic if the current locale is 'ar'
  String translateSpecialty(BuildContext context) {
    final lower = toLowerCase();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    if (!isArabic) return this;

    if (lower.contains('cardio') || lower.contains('heart')) return 'قلبية';
    if (lower.contains('derma') || lower.contains('skin')) return 'جلدية';
    if (lower.contains('neuro') || lower.contains('brain')) return 'أعصاب';
    if (lower.contains('ortho') || lower.contains('bone')) return 'عظام';
    if (lower.contains('pediatr') || lower.contains('child')) return 'أطفال';
    if (lower.contains('dent')) return 'أسنان';
    if (lower.contains('eye') || lower.contains('ophthal')) return 'عيون';
    if (lower.contains('ent') || lower.contains('ear')) return 'أنف وأذن وحنجرة';
    if (lower.contains('psych') || lower.contains('mental')) return 'نفسية';
    if (lower.contains('radio') || lower.contains('scan') || lower.contains('xray')) return 'أشعة';
    if (lower.contains('onco') || lower.contains('cancer')) return 'أورام';
    if (lower.contains('uro') || lower.contains('urinary')) return 'مسالك بولية';
    if (lower.contains('nephro') || lower.contains('kidney')) return 'كلى';
    if (lower.contains('gastro') || lower.contains('stomach')) return 'جهاز هضمي';
    if (lower.contains('endo') || lower.contains('hormone')) return 'غدد صماء';
    if (lower.contains('pulmo') || lower.contains('lung')) return 'صدرية';
    if (lower.contains('hema') || lower.contains('blood')) return 'دم';
    if (lower.contains('rheuma') || lower.contains('joint')) return 'روماتيزم';
    if (lower.contains('infect') || lower.contains('virus')) return 'أمراض معدية';
    if (lower.contains('anesth')) return 'تخدير';
    if (lower.contains('emergency') || lower.contains('er')) return 'طوارئ';
    if (lower.contains('gyne') || lower.contains('obstetric') || lower.contains('pregnan')) return 'نساء وتوليد';
    if (lower.contains('surgery') || lower.contains('surgeon')) return 'جراحة';
    if (lower.contains('plastic') || lower.contains('cosmetic')) return 'تجميل';
    if (lower.contains('vascular')) return 'أوعية دموية';
    if (lower.contains('therapy') || lower.contains('physio')) return 'علاج طبيعي';
    if (lower.contains('sports')) return 'طب رياضي';
    if (lower.contains('allergy') || lower.contains('immun')) return 'حساسية ومناعة';
    if (lower.contains('geriatric') || lower.contains('elder')) return 'طب المسنين';
    if (lower.contains('patho') || lower.contains('lab')) return 'تحاليل طبية';
    if (lower.contains('pain')) return 'علاج الألم';
    if (lower.contains('critical') || lower.contains('icu')) return 'رعاية مركزة';
    if (lower.contains('general')) return 'باطنة عامة';

    return this;
  }
}
