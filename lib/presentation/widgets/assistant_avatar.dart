import 'package:ai_chat_bot/presentation/widgets/figma_assets.dart';
import 'package:flutter/material.dart';

class AssistantAvatar extends StatelessWidget {
  const AssistantAvatar({super.key, this.size = 26});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x34000000),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          figmaRobotLogoUrl,
          width: size,
          height: size,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
