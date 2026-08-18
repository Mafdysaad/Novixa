import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/presentation/widgets/ai_bubble.dart';

import 'package:ai_chat_bot/presentation/widgets/user_bubble.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    super.key,
    required ScrollController scrollController,
    required this.messages,
    required this.isLoding,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Content> messages;
  final bool isLoding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: isLoding ? messages.length + 1 : messages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        final isUser = index.isEven;
        if (isLoding && index == messages.length) {
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
              ? AiBubble(message: messages[index].text!)
              : UserBubble(message: messages[index].text!),
        );
      },
    );
  }
}
