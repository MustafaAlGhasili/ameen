import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String text;

  const CustomContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: width * 0.025),
      width: width,
      height: height * 0.06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black)),
      child: Text(
        text,
        style: TextStyle(fontSize: width * 0.04),
      ),
    );
  }
}
