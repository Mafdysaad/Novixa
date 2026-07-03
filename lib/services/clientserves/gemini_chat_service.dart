import 'package:dio/dio.dart';
import 'package:ai_chat_bot/models/chat_message_model.dart';
import 'package:ai_chat_bot/services/clientserves/api_clinetservice.dart';

class GeminiChatService {
  GeminiChatService({required ApiClientService client}) : _client = client;

  final ApiClientService _client;

  /// Sends a list of `ChatMessageModel` to Gemini and returns the first text reply as `ChatMessageModel`.
  Future<ChatMessageModel> sendMessage(
    List<ChatMessageModel> input, {
    String model = 'gemini-3.5-flash',
  }) async {
    final payload = {
      'model': model,
      'input': input.map((e) => e.toJson()).toList(),
    };

    final response = await _client.post(
      '/v1beta/interactions',
      data: payload,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    return ChatMessageModel.fromJson(response.data);
  }
}
