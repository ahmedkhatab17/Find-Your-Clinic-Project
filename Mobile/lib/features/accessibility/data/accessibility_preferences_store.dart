import 'package:shared_preferences/shared_preferences.dart';

/// Persists accessibility preferences locally. Mirrors the SharedPreferences
/// pattern used by [ThemeModeCubit].
class AccessibilityPreferencesStore {
  static const _kVoiceCardEnabled = 'voice_assistant_card_enabled';

  Future<bool> isVoiceCardEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    // Default to false — users opt-in via Settings → Accessibility.
    return prefs.getBool(_kVoiceCardEnabled) ?? false;
  }

  Future<void> setVoiceCardEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kVoiceCardEnabled, value);
  }
}
