import 'package:ai_chat_bot/core/error/errors.dart';
import 'package:ai_chat_bot/models/chat_message_model/chat_message_model.dart';
import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/repositories/chat_repository.dart';

import 'package:ai_chat_bot/services/clientserves/gemini_chat_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class GeminiChatRepository implements ChatRepository {
  GeminiChatRepository({required this.geminiChatService});

  final GeminiChatService geminiChatService;

  @override
  Future<Either<ChatMessageModel, ServerFailure>> sendMessage(
    List<Content> messages,
  ) async {
    if (messages.length > 20) {
      messages = messages.sublist(-5);
    }
    try {
      var respons = await geminiChatService.sendMessage(messages);
      return left(respons);
    } on DioException catch (e) {
      return right(ServerFailure.fromDioException(e));
    } catch (e) {
      return right(ServerFailure(e.toString()));
    }
  }
}
