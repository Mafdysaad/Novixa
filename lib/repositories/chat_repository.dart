import 'package:ai_chat_bot/core/error/errors.dart';
import 'package:ai_chat_bot/models/chat_message_model/chat_message_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<ChatMessageModel, ServerFailure>> sendMessage(
    List<ChatMessageModel> messages,
  );
}
