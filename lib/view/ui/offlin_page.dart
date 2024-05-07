import 'package:flutter/material.dart';


class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
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
        ),
      ),
    );
  }
}
