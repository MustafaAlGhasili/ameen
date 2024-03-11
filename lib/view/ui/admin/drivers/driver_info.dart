import 'package:ameen/view/ui/widget/cusom_dialog.dart';

import 'driver_presoanl_info.dart';
import 'student_with_driver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/button_model.dart';

class DriverInfo extends StatelessWidget {
  final driver;

  const DriverInfo({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          foregroundColor: Colors.white,
          title: const Text("معلومات السائق"),
          centerTitle: true,
        ),
        body: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.1),
                child: Container(
                  height: height * 0.2,
                  width: width * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      border: Border.all(
                          color: const Color.fromARGB(255, 113, 65, 146))),
                  child: Image(
                    width: width * 0.27,
                    image: AssetImage(driver['img']),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  driver['name'],
                  style: TextStyle(fontSize: width * 0.05),
                ),
              ),
              ButtonModel(
                  onTap: () {
                    Get.to(() => const StudentWithBusName());
                  },
                  padding: 10,
                  hMargin: width * 0.05,
                  vMargin: height * 0.015,
                  height: height * 0.08,
                  rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                  backColor: const Color.fromARGB(255, 113, 65, 146),
                  style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                  // textAlign: TextAlign.center,
                  content: "قائمة الطلاب"),
              ButtonModel(
                  onTap: () {
                    Get.to(() => const DriverPInfo());
                  },
                  padding: 10,
                  hMargin: width * 0.05,
                  vMargin: height * 0.015,
                  height: height * 0.08,
                  rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                  backColor: const Color.fromARGB(255, 113, 65, 146),
                  style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                  // textAlign: TextAlign.center,
                  content: "المعلومات الشخصية"),
              SizedBox(
                height: height * 0.04,
              ),
              ButtonModel(
                  onTap: () {
                    Get.dialog(
                      CustomDialog(buttonText: "نعم", content: "هل متأكد من حذف الحساب؟")
                    );
                  },
                  padding: 10,
                  hMargin: width * 0.05,
                  vMargin: height * 0.02,
                  height: height * 0.08,
                  rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                  backColor: Colors.red,
                  style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                  // textAlign: TextAlign.center,
                  content: "حذف الحساب"),
            ],
          ),
        ),
      ),
    );
  }
}
