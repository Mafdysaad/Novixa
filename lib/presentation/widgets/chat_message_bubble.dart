import 'package:flutter/material.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isUser,
    this.maxWidth = 252,
  });

  final String message;
  final bool isUser;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isUser
        ? const Color(0xFF3369FF)
        : const Color(0xFFF0F0F0);
    final textColor = isUser
        ? Colors.white
        : message.length > 60
        ? const Color(0xFF656565)
        : const Color(0xFF505050);
    final fontWeight = isUser || message.length <= 60
        ? FontWeight.w700
        : FontWeight.w400;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: isUser
              ? const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(25),
                ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            height: 1.5,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
