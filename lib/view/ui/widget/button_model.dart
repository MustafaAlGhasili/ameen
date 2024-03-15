// import 'package:flutter/material.dart';
//
// class ButtonModel extends StatelessWidget {
//   final double? width;
//   final double? height;
//   final String content;
//   final TextStyle? style;
//   final Color? backColor;
//   final void Function()? onTap;
//   final TextAlign? textAlign;
//   final IconData? icon;
//   final double? iconSize;
//   final double vMargin;
//   final double hMargin;
//   final double? textWidth;
//   final MainAxisAlignment rowMainAxisAlignment;
//   final double padding;
//
//   const ButtonModel(
//       {super.key,
//       this.width,
//       this.height,
//       required this.content,
//       this.style,
//       this.backColor,
//       this.onTap,
//       this.textAlign,
//       this.icon,
//       this.iconSize,
//       this.vMargin = 0,
//       this.hMargin = 0,
//       this.textWidth,
//       this.rowMainAxisAlignment = MainAxisAlignment.start,
//       this.padding = 0.0});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//           margin: EdgeInsets.symmetric(vertical: vMargin, horizontal: hMargin),
//           padding: EdgeInsets.all(padding),
//           decoration: BoxDecoration(
//               color: backColor, borderRadius: BorderRadius.circular(15)),
//           width: width,
//           height: height,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 00.0),
//             child: Row(
//               mainAxisAlignment: rowMainAxisAlignment,
//               children: [
//                 Text(
//                   textAlign: TextAlign.center,
//                   content,
//                   style: style,
//                 ),
//                 Icon(icon, color: Colors.white, size: iconSize),
//               ],
//             ),
//           )),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ButtonModel extends StatelessWidget {
  final double? width;
  final double? height;
  final String content;
  final TextStyle? style;
  final Color? backColor;
  final void Function()? onTap;
  final TextAlign? textAlign;
  final String imgUrl;
  final double? preIconSize;
  final double? sufIconSize;
  final double vMargin;
  final double hMargin;
  final double? textWidth;
  final MainAxisAlignment rowMainAxisAlignment;
  final double padding;
  final String busName;
  final bool bus;
  final IconData? icon;
  final double? iconSize;
  final enableIcon;
  final double contentPdding;

  const ButtonModel(
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
      this.imgUrl = '',
      this.busName = '',
      this.bus = false,
      this.icon,
      this.iconSize,
      this.enableIcon = false,
      this.contentPdding = 0.0});

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
                imgUrl.isEmpty
                    ? const Text('')
                :CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Image(image: AssetImage("img/st1.png")),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(contentPdding),
                  child: Text(
                    textAlign: TextAlign.center,
                    content,
                    style: style,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      busName,
                      style: const TextStyle(color: Colors.white),
                    ),
                    bus
                        ? const Icon(
                            Icons.directions_bus_rounded,
                            color: Colors.white,
                          )
                        : const Text(''),
                    enableIcon
                        ? Icon(icon, color: Colors.white, size: iconSize)
                        : Text(''),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
