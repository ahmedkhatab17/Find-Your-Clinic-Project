import 'package:shared_preferences/shared_preferences.dart';

/// Persists accessibility preferences locally. Mirrors the SharedPreferences
/// pattern used by [ThemeModeCubit].
class AccessibilityPreferencesStore {
  static const _kVoiceCardEnabled = 'voice_assistant_card_enabled';

  Future<bool> isVoiceCardEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    // Default to true so blind users discover the feature on first install.
    return prefs.getBool(_kVoiceCardEnabled) ?? true;
  }

  Future<void> setVoiceCardEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kVoiceCardEnabled, value);
  }
}
