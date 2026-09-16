import 'package:ai_chat_bot/presentation/widgets/figma_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.contentWidth});

  final double contentWidth;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      figmaDividerLineUrl,
      width: contentWidth,
      height: 1,
    );
  }
}
