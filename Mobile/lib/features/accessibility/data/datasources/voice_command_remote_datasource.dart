import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/voice_command_response_model.dart';

abstract class VoiceCommandRemoteDataSource {
  Future<VoiceCommandResponseModel> processVoiceCommand({
    required String transcript,
    String? currentScreen,
    String? screenContextJson,
  });
}

class VoiceCommandRemoteDataSourceImpl implements VoiceCommandRemoteDataSource {
  final ApiClient _apiClient;

  VoiceCommandRemoteDataSourceImpl(this._apiClient);

  @override
  Future<VoiceCommandResponseModel> processVoiceCommand({
    required String transcript,
    String? currentScreen,
    String? screenContextJson,
  }) async {
    final response = await _apiClient.dio.post(
      ApiEndpoints.aiVoiceCommand,
      data: {
        'transcript': transcript,
        'currentScreen': ?currentScreen,
        'screenContextJson': ?screenContextJson,
      },
    );
    return VoiceCommandResponseModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }
}
