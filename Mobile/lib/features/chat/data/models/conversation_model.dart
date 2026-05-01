import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  const ConversationModel({
    required super.id,
    required super.patientId,
    required super.doctorId,
    required super.lastMessageAt,
    super.lastMessage,
    super.counterpartyName,
    super.counterpartyImageUrl,
    required super.unreadCount,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: (json['id'] ?? json['conversationId']) as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      lastMessageAt: parseServerDateTime(json['lastMessageAt'] as String),
      lastMessage: json['lastMessage'] as String?,
      counterpartyName: json['counterpartyName'] as String?,
      counterpartyImageUrl: json['counterpartyImageUrl'] as String?,
      unreadCount: json['unreadCount'] as int,
    );
  }
}
