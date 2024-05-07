import 'package:Amin/controller/home_controller.dart';
import 'package:Amin/view/ui/map/track_student_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'state_page.dart';

HomeController controller = Get.find();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Positioned(
              // top: 100,
              child: Container(
                alignment: Alignment.center,
                height: height * 0.4,
                width: width,
                color: const Color.fromARGB(255, 113, 65, 146),
                child: Image(
                  fit: BoxFit.scaleDown,
                  gaplessPlayback: false,
                  width: width * 0.7,
                  image: const AssetImage("img/logo.png"),
                ),
              ),
            ),
            Positioned(
              top: height * 0.35,
              child: Container(
                width: width,
                height: height * 0.7,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    )),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      height: height * 0.09,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.map.value = false;
                            },
                            child: Container(
                              decoration: const BoxDecoration(),
                              alignment: Alignment.center,
                              height: height * 0.09,
                              width: width * 0.5,
                              child: Text(
                                "الحالة ",
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: width * 0.05,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => TrackStudentMap());

                              //controller.map.value = true;
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.09,
                              width: width * 0.5,
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                              child: Text(
                                "الخريطه ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: width * 0.05,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const StatePage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
