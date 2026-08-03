import 'package:ai_chat_bot/models/chat_message_model.dart';

abstract class ChatRepository {
  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages);
}
