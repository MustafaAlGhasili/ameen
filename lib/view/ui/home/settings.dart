import 'package:ameen/controller/home_controller.dart';
import 'package:ameen/view/ui/home/supoort.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    HomeController controller = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: Colors.black,
          elevation: 2,
          centerTitle: true,
          title: Text("الإعدادات", style: TextStyle(fontSize: width * 0.05)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.05),
          child: SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  width: width * 0.9,
                  height: height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "الإشعارات",
                        style: TextStyle(fontSize: width * 0.045),
                      ),
                      Obx(
                        () => Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            activeColor: Colors.white,
                            activeTrackColor:
                                const Color.fromARGB(255, 113, 65, 146),
                            dragStartBehavior: DragStartBehavior.start,
                            inactiveTrackColor: Colors.white,
                            inactiveThumbColor:
                                const Color.fromARGB(255, 113, 65, 146),
                            value: controller.notificationOn.value,
                            onChanged: (val) {
                              controller.notificationOn.value =
                                  !controller.notificationOn.value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const Support());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                        )),
                    width: width * 0.9,
                    height: height * 0.06,
                    margin: EdgeInsets.symmetric(vertical: height * 0.03),
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04, vertical: height * 0.01),
                    child: Text(
                      "الدعم",
                      style: TextStyle(fontSize: width * 0.045),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
