import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'figma_assets.dart';

class ChatBotAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatBotAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(92);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 92,
      titleSpacing: 0,
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SvgPicture.asset(figmaIconArrowLeftUrl, width: 24, height: 24),
      ),
      title: Row(
        children: [
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SvgPicture.asset(
              figmaRobotLogoUrl,
              width: 24,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ChatGPT',
                style: TextStyle(
                  color: Color(0xFF3369FF),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  SvgPicture.asset(figmaOnlineDotUrl, width: 6, height: 6),
                  const SizedBox(width: 5),
                  const Text(
                    'Online',
                    style: TextStyle(
                      color: Color(0xFF3ABF38),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: Row(
            children: [
              SvgPicture.asset(figmaIconVolumeUrl, width: 24, height: 24),
              const SizedBox(width: 19),
              SvgPicture.asset(figmaIconExportUrl, width: 24, height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
