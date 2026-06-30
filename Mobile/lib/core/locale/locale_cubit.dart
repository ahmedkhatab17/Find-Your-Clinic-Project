import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the app's locale. State is `Locale?` where `null` means
/// "follow system locale". Mirrors the [ThemeModeCubit] pattern exactly.
class LocaleCubit extends Cubit<Locale?> {
  static const _kLocaleCode = 'locale_code';

  LocaleCubit() : super(null);

  /// Load persisted locale preference. Called once at app startup.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_kLocaleCode);
    if (code != null) {
      emit(Locale(code));
    }
    // else stays null → system locale
  }

  /// Set locale explicitly. Pass `null` to follow system locale.
  Future<void> setLocale(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_kLocaleCode);
    } else {
      await prefs.setString(_kLocaleCode, locale.languageCode);
    }
    emit(locale);
  }

  /// Returns the effective language code, falling back to the platform locale
  /// when state is `null` (system default).
  String get effectiveLanguageCode {
    return state?.languageCode ??
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  }
}
