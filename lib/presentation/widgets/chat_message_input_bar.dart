import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'figma_assets.dart';

class ChatMessageInputBar extends StatelessWidget {
  const ChatMessageInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.13),
        color: Colors.white,
        child: Container(
          width: 333,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Write your message',
                    hintStyle: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onSubmitted: (_) => onSend(),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.network(
                  figmaIconMicrophoneUrl,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onSend,
                child: SvgPicture.network(
                  figmaIconSendUrl,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
