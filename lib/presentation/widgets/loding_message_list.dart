import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/presentation/widgets/ai_bubble.dart';

import 'package:ai_chat_bot/presentation/widgets/user_bubble.dart';
import 'package:flutter/material.dart';

class LodingMessageList extends StatelessWidget {
  const LodingMessageList({
    super.key,
    required ScrollController scrollController,
    required this.messages,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Content> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      physics: const ClampingScrollPhysics(),
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: messages.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        print("=================> $index");
        print("=================> ${messages.length}");

        var newIndex = messages.length - index;
        final isUser = index.isEven;
        if (index == 0) {
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
