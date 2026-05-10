import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/failure.dart';
import '../../domain/entities/screen_context.dart';
import '../../domain/entities/voice_command_result.dart';
import '../../domain/repos/voice_command_repository.dart';
import '../datasources/voice_command_remote_datasource.dart';

class VoiceCommandRepositoryImpl implements VoiceCommandRepository {
  final VoiceCommandRemoteDataSource _dataSource;

  VoiceCommandRepositoryImpl({required VoiceCommandRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<ApiResult<VoiceCommandResult>> processVoiceCommand({
    required String transcript,
    ScreenContext context = ScreenContext.unknown,
  }) async {
    try {
      final model = await _dataSource.processVoiceCommand(
        transcript: transcript,
        currentScreen: context.screen.label,
        screenContextJson: context.toJsonOrNull(),
      );
      return Success(model.toEntity(originalTranscript: transcript));
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }
}
