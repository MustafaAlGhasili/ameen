import 'package:ameen/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomState extends StatelessWidget {
  final bool state;
  final String childText;
  final String text;

  const CustomState(
      {super.key,
      required this.childText,
      required this.text,
      required this.state});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(right: width * 0.08, top: height * 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: height * 0.055,
            width: height * 0.055,
            decoration: BoxDecoration(
              color: state ? PRIMARY_COLOR : Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(1000),
            ),
            child: state
                ? Icon(
                    Icons.done,
                    color: Colors.white,
                    size: width * 0.05,
                  )
                : Text(
                    childText,
                    style: TextStyle(fontSize: width * 0.045),
                  ),
          ),
          SizedBox(
            width: width * 0.04,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: width * 0.05,
            ),
          ),
        ],
      ),
    );
  }
}
