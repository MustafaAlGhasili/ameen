import 'package:flutter/material.dart';

class ButtonModel extends StatelessWidget {
  final double? width;
  final double? height;
  final String content;
  final TextStyle? style;
  final Color? backColor;
  final void Function()? onTap;
  final TextAlign? textAlign;
  final IconData? icon;
  final double? iconSize;
  final double vMargin;
  final double hMargin;
  final double? textWidth;
  final MainAxisAlignment rowMainAxisAlignment;
  final double padding;

  const ButtonModel(
      {super.key,
      this.width,
      this.height,
      required this.content,
      this.style,
      this.backColor,
      this.onTap,
      this.textAlign,
      this.icon,
      this.iconSize,
      this.vMargin = 0,
      this.hMargin = 0,
      this.textWidth,
      this.rowMainAxisAlignment = MainAxisAlignment.start,
      this.padding = 0.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: vMargin, horizontal: hMargin),
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
              color: backColor, borderRadius: BorderRadius.circular(15)),
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 00.0),
            child: Row(
              mainAxisAlignment: rowMainAxisAlignment,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  content,
                  style: style,
                ),
                Icon(icon, color: Colors.white, size: iconSize),
              ],
            ),
          )),
    );
  }
}
