// Pure Dart — no Flutter imports.

import 'voice_command_intent.dart';

/// Backend response to a one-shot voice command call.
class VoiceCommandResult {
  /// Strongly-typed intent extracted by Gemini.
  final VoiceCommandIntent intent;

  /// Short natural-language sentence the app should speak aloud.
  final String spokenResponse;

  const VoiceCommandResult({
    required this.intent,
    required this.spokenResponse,
  });
}
