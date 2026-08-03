import 'package:ai_chat_bot/models/chat_message_model.dart';
import 'package:ai_chat_bot/repositories/chat_repository.dart';

import 'package:ai_chat_bot/services/clientserves/gemini_chat_service.dart';

class GeminiChatRepository implements ChatRepository {
  GeminiChatRepository({required this.geminiChatService});

  final GeminiChatService geminiChatService;

  @override
  Future<ChatMessageModel> sendMessage(List<ChatMessageModel> messages) async {
    return geminiChatService.sendMessage(messages);
  }
}
