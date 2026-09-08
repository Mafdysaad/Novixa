import 'package:ai_chat_bot/core/constant/apiconstant.dart';
import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:dio/dio.dart';

import 'package:ai_chat_bot/models/chat_message_model/chat_message_model.dart';
import 'package:ai_chat_bot/services/clientserves/api_clinetservice.dart';

class GeminiChatService {
  GeminiChatService({required ApiClientService client}) : _client = client;

  final ApiClientService _client;

  /// Sends a list of `ChatMessageModel` to Gemini and returns the first text reply as `ChatMessageModel`.
  Future<ChatMessageModel> sendMessage({
    required List<Content> input,
    String model = 'gemini-3.5-flash',
  }) async {
    final payload = {
      'model': model,
      'input': input.map((e) => e.toJson()).toList(),
    };

    late Exception exaption;
    for (int i = 0; i < 3; i++) {
      try {
        final response = await _client.post(
          '/v1beta/interactions',
          data: payload,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'x-goog-api-key': Apiconstant.apiKay,
            },
          ),
        );
        return ChatMessageModel.fromJson(response.data);
      } on DioException catch (e) {
        if (!_isRetryableDioException(e)) {
          rethrow;
        }
        exaption = e;
        if (i < 2) {
          await Future.delayed(Duration(seconds: i + 1));
        }
      }
    }
    throw exaption;
  }

  bool _isRetryableDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
        return false;
      case DioExceptionType.unknown:
        return false;
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == null) {
          return false;
        }
        return code == 408 || code == 429 || (code >= 500 && code < 600);
    }
  }
}
