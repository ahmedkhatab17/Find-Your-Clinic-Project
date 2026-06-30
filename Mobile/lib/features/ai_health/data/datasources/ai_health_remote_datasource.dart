import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/ai_chat_message_model.dart';
import '../models/symptom_analysis_model.dart';

abstract class AiHealthRemoteDataSource {
  Future<AiChatMessageModel> sendMessage(String content, String language);
  Future<List<AiChatMessageModel>> getChatHistory();
  Future<SymptomAnalysisModel> analyzeSymptoms(List<String> symptoms, String language);
}

class AiHealthRemoteDataSourceImpl implements AiHealthRemoteDataSource {
  final ApiClient _apiClient;

  AiHealthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<AiChatMessageModel> sendMessage(String content, String language) async {
    final response = await _apiClient.dio.post(
      ApiEndpoints.aiChat,
      data: {'content': content, 'language': language},
    );
    return AiChatMessageModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<AiChatMessageModel>> getChatHistory() async {
    final response = await _apiClient.dio.get(ApiEndpoints.aiChatHistory);
    final data = response.data['data'] as List;
    return data.map((e) => AiChatMessageModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<SymptomAnalysisModel> analyzeSymptoms(List<String> symptoms, String language) async {
    final response = await _apiClient.dio.post(
      ApiEndpoints.aiSymptomsAnalyze,
      data: {'symptoms': symptoms, 'language': language},
    );
    return SymptomAnalysisModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}
