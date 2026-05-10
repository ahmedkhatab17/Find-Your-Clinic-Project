// Pure Dart — no Flutter imports.

import '../../../../core/network/api_result.dart';
import '../entities/screen_context.dart';
import '../entities/voice_command_result.dart';
import '../repos/voice_command_repository.dart';

class ProcessVoiceCommandUseCase {
  final VoiceCommandRepository _repository;
  const ProcessVoiceCommandUseCase(this._repository);

  Future<ApiResult<VoiceCommandResult>> call({
    required String transcript,
    ScreenContext context = ScreenContext.unknown,
  }) =>
      _repository.processVoiceCommand(
        transcript: transcript,
        context: context,
      );
}
