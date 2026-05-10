import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

/// Wraps [FlutterTts] to provide text-to-speech with a stream for UI state.
class TtsService {
  final FlutterTts _tts = FlutterTts();
  final StreamController<bool> _speakingCtrl =
      StreamController<bool>.broadcast();

  /// Whether TTS is currently speaking.
  Stream<bool> get isSpeaking => _speakingCtrl.stream;
  bool _isSpeaking = false;
  bool get isSpeakingNow => _isSpeaking;

  /// ID of the message currently being spoken (for UI highlight).
  String? _currentMessageId;
  String? get currentMessageId => _currentMessageId;

  TtsService() {
    _init();
  }

  Future<void> _init() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);

    _tts.setStartHandler(() {
      _isSpeaking = true;
      _speakingCtrl.add(true);
    });

    _tts.setCompletionHandler(() {
      _isSpeaking = false;
      _currentMessageId = null;
      _speakingCtrl.add(false);
    });

    _tts.setCancelHandler(() {
      _isSpeaking = false;
      _currentMessageId = null;
      _speakingCtrl.add(false);
    });

    _tts.setErrorHandler((_) {
      _isSpeaking = false;
      _currentMessageId = null;
      _speakingCtrl.add(false);
    });
  }

  /// Speak the given [text]. If already speaking, stops first.
  /// [messageId] can be used by UI to highlight the active message.
  Future<void> speak(String text, {String? messageId}) async {
    if (_isSpeaking) await stop();
    _currentMessageId = messageId;
    await _tts.speak(text);
  }

  /// Stop speaking.
  Future<void> stop() async {
    await _tts.stop();
    _isSpeaking = false;
    _currentMessageId = null;
    _speakingCtrl.add(false);
  }

  /// Clean up resources.
  void dispose() {
    _tts.stop();
    _speakingCtrl.close();
  }
}
