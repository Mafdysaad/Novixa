import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:flutter/material.dart';

class Gnerallistview extends StatelessWidget {
  const Gnerallistview({
    super.key,
    required ScrollController scrollController,
    required this.messages,
    required this.itemBuilder,
  }) : _scrollController = scrollController;
  final ScrollController _scrollController;
  final List<Content> messages;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      physics: const ClampingScrollPhysics(),
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: messages.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemBuilder: itemBuilder,
    );
  }
}
