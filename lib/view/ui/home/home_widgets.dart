import 'dart:math';

import 'package:ameen/controller/home_controller.dart';
import 'package:ameen/view/ui/home/settings.dart';
import 'package:ameen/view/ui/home/student_info.dart';
import 'package:ameen/view/ui/widget/custom_divider.dart';
import 'package:ameen/view/ui/widget/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';

import '../widget/button_model.dart';

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
                child: Obx(
                  () => Column(
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
                                controller.map.value = true;
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
                      controller.map.value ? const Map() : const State(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}









class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Define a single point on the map
    LatLng point1 = LatLng(24.6583445, 46.6917818);
    LatLng point2 = LatLng(24.8583445, 46.6917818);
    ;

    List<LatLng> polylinePoints = [point1, point2];


    return SizedBox(
      height: height * 0.7,
      width: width,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: point1,
          zoom: 15.0, // Set the desired zoom level for the first point
        ),
        myLocationEnabled: true,
        markers: <Marker>{
          Marker(
            markerId: MarkerId('markerId1'),
            position: point1,
            infoWindow: InfoWindow(
              title: 'Marker 1',
              snippet: 'Point 1',
            ),
          ),
          Marker(
            markerId: const MarkerId('markerId2'),
            position: point2,
            infoWindow: InfoWindow(
              title: 'Marker 2',
              snippet: 'Point 2',
            ),
          ),
        },
/*
        polylines: <Polyline>{
          Polyline(
            polylineId: PolylineId('polylineId'),
            points: polylinePoints,
            color: Colors.blue, // Set the color of the polyline
            width: 5, // Set the width of the polyline
          ),
        },
*/
        // Padding is added to ensure the marker is not at the edges of the screen
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}

class State extends StatelessWidget {
  const State({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Positioned(
      top: height * 0.35,
      child: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Obx(() => CustomState(
                state: controller.isInTheWay.value,
                childText: "1",
                text: "في الطريق",
              )),
          CustomDivider(
            height: height * 0.05,
            rightMargin: width * 0.132,
          ),
          Obx(() => CustomState(
                state: controller.isClose.value,
                childText: "2",
                text: "على وشك الوصول",
              )),
          CustomDivider(
            height: height * 0.05,
            rightMargin: width * 0.132,
          ),
          Obx(() => CustomState(
                state: controller.isArraived.value,
                childText: "3",
                text: "وصلت الحافلة",
              )),
        ],
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.all(width * 0.015),
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
                  padding: EdgeInsets.all(width * 0.015),
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("الملف الشخصي",
                  style: TextStyle(
                    fontSize: width * 0.07,
                  )),
              SizedBox(height: height * 0.015),
              CircleAvatar(
                radius: width * 0.22,
                backgroundColor: Colors.white,
                // backgroundImage: AssetImage("img/profile.png"),
                foregroundImage: const AssetImage("img/profile.png"),
              ),
              Text(
                "سارة عبدالعزيز",
                style: TextStyle(
                  fontSize: width * 0.06,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ButtonModel(
                rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                width: width * 0.9,
                height: height * 0.07,
                onTap: () {
                  Get.to(() => const StudentInfo());
                },
                backColor: const Color.fromARGB(255, 113, 65, 146),
                content: "حسابي",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                icon: IconlyLight.profile,
                iconSize: width * 0.06,
                vMargin: height * 0.01,
              ),
              ButtonModel(
                rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                width: width * 0.9,
                height: height * 0.07,
                onTap: () {},
                backColor: const Color.fromARGB(255, 113, 65, 146),
                content: "اشعار غياب",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                icon: Icons.inbox_outlined,
                iconSize: width * 0.06,
                vMargin: height * 0.01,
              ),
              ButtonModel(
                rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                width: width * 0.9,
                height: height * 0.07,
                onTap: () {
                  Get.to(() => const Settings());
                },
                backColor: const Color.fromARGB(255, 113, 65, 146),
                content: "الإعدادات",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                icon: IconlyLight.setting,
                iconSize: width * 0.06,
                vMargin: height * 0.01,
              ),
              ButtonModel(
                rowMainAxisAlignment: MainAxisAlignment.center,
                width: width * 0.9,
                height: height * 0.07,
                onTap: () {},
                backColor: Colors.red,
                content: "تسجيل خروج",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                vMargin: height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
