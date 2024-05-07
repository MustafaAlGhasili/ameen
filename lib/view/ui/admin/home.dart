import 'package:Amin/view/ui/admin/drivers/drivers_list.dart';
import 'package:Amin/view/ui/admin/students/students_list.dart';
import 'package:Amin/view/ui/sign/start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/admin_controller.dart';
import '../widget/button_model.dart';
import '../widget/custom_dialog.dart';
import 'admin_notification.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(() => AdminController());

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: IconButton(
                onPressed: () async {
                  Get.dialog(
                    CustomDialog(
                        buttonOnTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Get.offAll(
                            const Start(),
                          );
                        },
                        buttonText: "نعم",
                        content: "هل انت متاكد من تسجيل الخروج؟"),
                  );
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: width * 0.08,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.08),
              height: height * 0.3,
              width: width,
              decoration: const BoxDecoration(
                // color: Color.fromARGB(255, 113, 65, 146),
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
                        Get.to(() => const DriversList());
                      },
                      vMargin: height * 0.05,
                      width: width * 0.87,
                      height: height * 0.067,
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      backColor: const Color.fromARGB(255, 113, 65, 146),
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.05),
                      // textAlign: TextAlign.center,
                      content: 'قائمة السائقين',
                    ),
                    ButtonModel(
                      onTap: () {
                        Get.to(() => const StudentsList());
                      },
                      width: width * 0.87,
                      height: height * 0.067,
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      backColor: const Color.fromARGB(255, 113, 65, 146),
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.05),
                      // textAlign: TextAlign.center,
                      content: 'قائمة الطلاب',
                    ),
                    ButtonModel(
                      onTap: () {
                        Get.to(() => const AdminNotifications());
                      },
                      vMargin: height * 0.05,
                      width: width * 0.87,
                      height: height * 0.067,
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
