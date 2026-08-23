import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/presentation/widgets/ai_bubble.dart';
import 'package:ai_chat_bot/presentation/widgets/fauiler_bubble.dart';
import 'package:ai_chat_bot/presentation/widgets/gneralListView.dart';

import 'package:ai_chat_bot/presentation/widgets/user_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FauilerMessageList extends StatelessWidget {
  const FauilerMessageList({
    super.key,
    required ScrollController scrollController,
    required this.messages,
    required this.text,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Content> messages;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Gnerallistview(
      scrollController: _scrollController,
      messages: messages,
      itemBuilder: (context, index) {
        final isUser = index.isEven;
        var newIndex = messages.length - (index + 1);
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.only(
              left: isUser ? 40 : 62,
              right: isUser ? 29 : 40,
            ),
            child: FauilerBubble(
              message: messages[messages.length - 1].text!,
              errormessage: text,
              onpressed: () {
                context.read<SendMessageCubit>().sendMessage(messages);
              },
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.only(
            left: isUser ? 40 : 62,
            right: isUser ? 29 : 40,
          ),
          child: !isUser
              ? AiBubble(message: messages[newIndex].text!)
              : UserBubble(message: messages[newIndex].text!),
        );
      },
    );
  }
}
