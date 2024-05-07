import 'package:Amin/model/driver.dart';
import 'package:Amin/utils/DatabaseHelper.dart';
import 'package:Amin/view/ui/widget/custom_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/button_model.dart';
import 'driver_presoanl_info.dart';
import 'student_with_driver.dart';

class DriverInfo extends StatelessWidget {
  final DriverModel driver;

  const DriverInfo({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper _databaseHelper = DatabaseHelper();

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
              SizedBox(
                height: height * 0.06
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(1),
                margin: EdgeInsets.only(top: height * 0.035),
                decoration: const BoxDecoration(
                    color: Colors.black, shape: BoxShape.circle),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: width * 0.23,
                  child: CachedNetworkImage(
                    imageUrl: driver.photo ?? " ",
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                    const Image(image: AssetImage("img/driver.png")),
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${driver.fName} ${driver.lName}",
                  style: TextStyle(fontSize: width * 0.05),
                ),
              ),
              ButtonModel(
                  onTap: () {
                    Get.to(() => StudentWithBusName(
                          busId: driver.busId,
                        ));
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
                    Get.to(() => DriverPInfo(
                          driver: driver,
                        ));
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
                  onTap: () async {
                    await _databaseHelper.testRef();
                    Get.dialog(CustomDialog(
                      buttonOnTap: () async {
                        await _databaseHelper.deleteById(driver.id, "drivers");
                        print("Clicked ${driver.id}");
                        Get.back();
                      },
                      buttonText: "نعم",
                      content: "هل متأكد من حذف الحساب؟",

                    ));
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
