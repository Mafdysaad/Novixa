import 'package:ai_chat_bot/presentation/widgets/assistant_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AiBubble extends StatelessWidget {
  const AiBubble({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const AssistantAvatar(),
        const SizedBox(width: 12),
        Flexible(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              constraints: BoxConstraints(maxWidth: 252),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: const Color(0xFF656565),
                  fontSize: 13,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
