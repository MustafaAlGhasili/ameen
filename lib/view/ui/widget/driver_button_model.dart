import 'package:flutter/material.dart';

class DriverButtonModel extends StatelessWidget {
  final double? width;
  final double? height;
  final String content;
  final TextStyle? style;
  final Color? backColor;
  final void Function()? onTap;
  final TextAlign? textAlign;
  final String imgPath;
  final double? preIconSize;
  final double? sufIconSize;
  final double vMargin;
  final double hMargin;
  final double? textWidth;
  final MainAxisAlignment rowMainAxisAlignment;
  final double padding;
  final String busName;
  final bool bus;

  const DriverButtonModel(
      {super.key,
      this.width,
      this.height,
      required this.content,
      this.style,
      this.backColor,
      this.onTap,
      this.textAlign,
      this.preIconSize,
      this.vMargin = 0,
      this.hMargin = 0,
      this.textWidth,
      this.rowMainAxisAlignment = MainAxisAlignment.start,
      this.padding = 0.0,
      this.sufIconSize,
      this.imgPath = '',
      this.busName = '',
      this.bus = false});

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
                imgPath.isEmpty
                    ? const Text('')
                    : CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Image(image: AssetImage(imgPath))),
                Text(
                  textAlign: TextAlign.center,
                  content,
                  style: style,
                ),
                Row(
                  children: [
                    Text(busName, style: const TextStyle(color: Colors.white),),
                    bus ? const Icon(
                      Icons.directions_bus_rounded,
                      color: Colors.white,
                    ): const Text('')
                  ],
                )
              ],
            ),
          )),
    );
  }
}
