import 'package:flutter/material.dart';

class ButtonModel extends StatelessWidget {
  final double? width;
  final double? height;
  final String content;
  final TextStyle? style;
  final Color? backColor;
  final void Function()? onTap;

  const ButtonModel(
      {super.key,
      this.width,
      this.height,
      required this.content,
      this.style,
      this.backColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(13)),
        width: width,
        height: height,
        child: Text(
          textAlign: TextAlign.center,
          content,
          style: style,
        ),
      ),
    );
  }
}
