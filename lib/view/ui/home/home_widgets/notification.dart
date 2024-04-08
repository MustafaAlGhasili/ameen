import 'package:ameen/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {

    HomeController controller = Get.find();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 10,
                  blurRadius: 3,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.bottomCenter,
            height: height * 0.07,
            width: width,
            child: Text(
              "الأشعارات",
              style: TextStyle(
                fontSize: width * 0.055,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.06, vertical: height * 0.01),
            width: width,
            child: Text(
              "اليوم",
              style: TextStyle(
                fontSize: width * 0.05,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            height: height * 0.37,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.studentStateNotification.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.all(width * 0.015),
                  padding: EdgeInsets.all(width * 0.04),
                  height: height * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("${controller.studentStateNotification[i]}",
                      style: TextStyle(fontSize: width * 0.045)),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.06, vertical: height * 0.02),
            width: width,
            child: Text(
              "اليوم السابق",
              style: TextStyle(
                fontSize: width * 0.05,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            height: height * 0.3,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.all(width * 0.015),
                  padding: EdgeInsets.all(width * 0.04),
                  height: height * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("تم تسجبل غياب الطالب",
                      style: TextStyle(fontSize: width * 0.045)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
