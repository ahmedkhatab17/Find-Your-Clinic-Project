sealed class VoiceAssistantState {
  const VoiceAssistantState();
}

class VoiceAssistantIdle extends VoiceAssistantState {
  const VoiceAssistantIdle();
}

class VoiceAssistantListening extends VoiceAssistantState {
  /// Current partial transcript from speech-to-text.
  final String partialTranscript;

  /// Sound level (0.0–1.0) for the pulsing mic animation.
  final double soundLevel;

  const VoiceAssistantListening({
    this.partialTranscript = '',
    this.soundLevel = 0.0,
  });
}

/// Transcript captured; calling Gemini for intent parsing.
class VoiceAssistantThinking extends VoiceAssistantState {
  final String transcript;
  const VoiceAssistantThinking(this.transcript);
}

/// TTS is speaking the response (or about to).
class VoiceAssistantSpoken extends VoiceAssistantState {
  final String spokenText;
  const VoiceAssistantSpoken(this.spokenText);
}

class VoiceAssistantError extends VoiceAssistantState {
  final String message;
  const VoiceAssistantError(this.message);
}
