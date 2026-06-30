import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../domain/entities/ai_chat_message.dart';
import '../../domain/usecases/get_chat_history_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final SendMessageUseCase _sendMessage;
  final GetChatHistoryUseCase _getHistory;

  AiChatCubit(this._sendMessage, this._getHistory) : super(AiChatInitial());

  Future<void> loadHistory() async {
    emit(AiChatLoading());
    final result = await _getHistory();
    switch (result) {
      case Success(:final data):
        emit(AiChatLoaded(data));
      case Error(:final failure):
        emit(AiChatError(failure.message));
    }
  }

  Future<void> sendMessage(String content, String language) async {
    final currentMessages = switch (state) {
      AiChatLoaded(:final messages) => messages,
      AiChatSending(:final messages) => messages,
      _ => <AiChatMessage>[],
    };

    // Optimistic: append user message immediately.
    final userMsg = AiChatMessage(
      role: 'user',
      content: content,
      createdAt: DateTime.now(),
    );
    emit(AiChatSending([...currentMessages, userMsg]));

    final result = await _sendMessage(content, language);
    switch (result) {
      case Success(:final data):
        emit(AiChatLoaded([...currentMessages, userMsg, data]));
      case Error(:final failure):
        final errorMsg = AiChatMessage(
          role: 'assistant',
          content: failure.message,
          createdAt: DateTime.now(),
        );
        emit(AiChatLoaded([...currentMessages, userMsg, errorMsg]));
    }
  }
}
