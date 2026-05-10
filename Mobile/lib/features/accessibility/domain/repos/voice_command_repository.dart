// Pure Dart — no Flutter imports.

import '../../../../core/network/api_result.dart';
import '../entities/screen_context.dart';
import '../entities/voice_command_result.dart';

abstract class VoiceCommandRepository {
  Future<ApiResult<VoiceCommandResult>> processVoiceCommand({
    required String transcript,
    ScreenContext context = ScreenContext.unknown,
  });
}
