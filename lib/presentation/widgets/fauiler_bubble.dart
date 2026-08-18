import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FauilerBubble extends StatelessWidget {
  const FauilerBubble({
    super.key,
    required this.message,
    required this.errormessage,
    required this.onpressed,
  });
  final String message;
  final String errormessage;
  final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            constraints: BoxConstraints(maxWidth: 252),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Color(0xFF3369FF),
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
                color: Colors.white,
                fontSize: 13,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: onpressed,
              icon: Icon(Icons.rotate_right_sharp, size: 20, color: Colors.red),
            ),
            Text(
              errormessage,
              style: TextStyle(
                color: const Color(0xFF656565),
                fontSize: 13,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
