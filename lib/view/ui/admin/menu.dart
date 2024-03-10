import 'package:ameen/view/ui/admin/drivers/drivers_list.dart';
import 'package:ameen/view/ui/admin/students/students_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/button_model.dart';
import 'notification.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 113, 65, 146),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: height * 0.035),
              height: height * 0.35,
              width: width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 113, 65, 146),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  image: AssetImage("img/logo.png"),
                ),
              ),
            ),
            Container(
                width: width,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.01),
                height: height * 0.55,
                margin: EdgeInsets.only(top: height * 0.45),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.065,
                    ),
                    ButtonModel(
                      onTap: () {
                        Get.to(()=> const DriversList());
                      },
                      vMargin: height * 0.05,
                      width: width * 0.87,
                      height: height * 0.06,
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      backColor: const Color.fromARGB(255, 113, 65, 146),
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.05),
                      // textAlign: TextAlign.center,
                      content: 'قائمة السائقين',
                    ),
                    ButtonModel(
                      onTap: () {
                        Get.to(()=> const StudentsList());
                      },
                      width: width * 0.87,
                      height: height * 0.06,
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      backColor: const Color.fromARGB(255, 113, 65, 146),
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.05),
                      // textAlign: TextAlign.center,
                      content: 'قائمة الطلاب',
                    ),
                    ButtonModel(
                      onTap: () {
                        Get.to(()=> const Notifications());
                      },
                      vMargin: height * 0.05,
                      width: width * 0.87,
                      height: height * 0.06,
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      backColor: const Color.fromARGB(255, 113, 65, 146),
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.05),
                      // textAlign: TextAlign.center,
                      content: 'الإشعارات',
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
