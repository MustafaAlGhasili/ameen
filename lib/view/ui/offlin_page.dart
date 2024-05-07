import 'package:Amin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("img/offline.png", height: width * 0.25),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          "لا يوجد اتصال بالانترنت!!",
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: width * 0.05),
        ),
      ],
    );
  }
}
