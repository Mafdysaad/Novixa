import 'package:ai_chat_bot/models/chat_message_model.dart';
import 'package:ai_chat_bot/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit({required ChatRepository repository})
    : _repository = repository,
      super(SendMessageInitial());

  final ChatRepository _repository;

  Future<void> sendMessage(List<ChatMessageModel> messages) async {
    emit(SendMessageLoading());

    try {
      final response = await _repository.sendMessage(messages);
      emit(SendMessageSuccess(message: response));
    } catch (error) {
      emit(SendMessageFailure(message: error.toString()));
    }
  }
}
