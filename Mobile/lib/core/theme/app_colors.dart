import 'dart:ui';

class AppColors {
  AppColors._();

  // ─── Primary ───
  static const primary = Color(0xFF11A8CD);
  static const primaryLight = Color(0xFF15BDE0);
  static const primaryDark = Color(0xFF0D7FA0);

  // ─── Secondary ───
  static const secondary = Color(0xFF0D7FA0);
  static const secondaryLight = Color(0xFF11A8CD);

  // ─── Gradient ───
  static const gradientStart = Color(0xFF0D7FA0);
  static const gradientMiddle = Color(0xFF11A8CD);
  static const gradientEnd = Color(0xFF15BDE0);

  // ─── Surface (Light) ───
  // Warm off-white — not pure white, avoids glare
  static const surface = Color(0xFFFAFCFD);
  static const surfaceAlt = Color(0xFFF0F5F8);
  static const scaffoldLight = Color(0xFFEFF5F8);

  // ─── Text (Light) ───
  // Deep charcoal, not pure black — gentler contrast
  static const textPrimary = Color(0xFF1C2B35);
  static const textSecondary = Color(0xFF5C6E7A);
  static const textHint = Color(0xFF9DB0BB);

  // ─── Status ───
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);

  // ─── Dark Mode ───
  // Deep teal-slate — harmonizes with teal primary, not harsh blue-purple
  static const darkBackground = Color(0xFF0F1E26);
  static const darkSurface = Color(0xFF172530);
  static const darkSurfaceAlt = Color(0xFF1F3040);
  // Soft off-white text — not pure white, reduces eye strain
  static const darkTextPrimary = Color(0xFFE8F2F6);
  static const darkTextSecondary = Color(0xFF8AAABB);

  // ─── Misc ───
  static const divider = Color(0xFFDDE8ED);
  static const shadow = Color(0x14000000);
  static const starRating = Color(0xFFF59E0B);
}
