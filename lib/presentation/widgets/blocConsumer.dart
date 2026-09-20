import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_state.dart';
import 'package:ai_chat_bot/presentation/widgets/fauiler_message_list.dart';
import 'package:ai_chat_bot/presentation/widgets/loding_message_list.dart';
import 'package:ai_chat_bot/presentation/widgets/messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class blocConsumerList extends StatelessWidget {
  const blocConsumerList({
    super.key,
    required this.messages,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final List<Content> messages;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: BlocConsumer<SendMessageCubit, SendMessageState>(
        listener: (context, state) {
          if (state is SendMessageSuccess) {
            messages.addAll(state.chatMessageModel.steps!.last.content!);
          }
        },
        builder: (context, state) {
          if (state is SendMessageLoading) {
            return LodingMessageList(
              scrollController: _scrollController,
              messages: messages,
            );
          }
          if (state is SendMessageFailure) {
            return FauilerMessageList(
              scrollController: _scrollController,
              messages: messages,
              text: state.message,
            );
          }
          return MessagesList(
            scrollController: _scrollController,
            messages: messages,
          );
        },
      ),
    );
  }
}
