import 'package:ai_chat_bot/models/chat_message_model.dart';

abstract class SendMessageState {}

class SendMessageInitial extends SendMessageState {}

class SendMessageLoading extends SendMessageState {}

class SendMessageSuccess extends SendMessageState {
  SendMessageSuccess({required this.message});

  final ChatMessageModel message;
}

class SendMessageFailure extends SendMessageState {
  SendMessageFailure({required this.message});

  final String message;
}
