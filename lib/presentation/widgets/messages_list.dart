import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/presentation/widgets/ai_bubble.dart';
import 'package:ai_chat_bot/presentation/widgets/gneralListView.dart';

import 'package:ai_chat_bot/presentation/widgets/user_bubble.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
    required ScrollController scrollController,
    required this.messages,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Content> messages;

  @override
  Widget build(BuildContext context) {
    return Gnerallistview(
      scrollController: _scrollController,
      messages: messages,
      itemBuilder: (context, index) {
        var newIndex = messages.length - (index + 1);
        final isUser = index.isEven;
        if (index == messages.length + index) {
          return Padding(
            padding: EdgeInsets.only(
              left: isUser ? 40 : 62,
              right: isUser ? 29 : 40,
            ),
            child: AiBubble(message: 'thina..'),
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
