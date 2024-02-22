import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double rightMargin;
  final double height;
  const CustomDivider(
      {super.key, required this.rightMargin, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: rightMargin),
      height: height,
      // width: width,
      // margin: EdgeInsetsDirectional.only(top: 1, bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          right:
              Divider.createBorderSide(context, color: Colors.black, width: 2),
        ),
      ),
    );
  }
}
