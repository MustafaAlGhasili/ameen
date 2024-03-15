import 'package:ameen/model/driver.dart';
import 'package:ameen/view/ui/admin/drivers/add_driver.dart';
import 'package:ameen/view/ui/admin/drivers/driver_presoanl_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import '../../../../utils/DatabaseHelper.dart';
import 'driver_info.dart';
import '../../widget/button_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class DriversList extends StatelessWidget {
  const DriversList({super.key});

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
          centerTitle: true,
          title: const Text(
            "قائمة السائقين",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.search,
                  color: Colors.white,
                ))
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  height: height * 0.75,
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: FirebaseAnimatedList(
                    query: DatabaseHelper.driverRef,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      DriverModel driver = DriverModel.fromSnapshot(snapshot);
                      if (snapshot.children.isEmpty) {
                        return const Center(
                          child: Text("No data found"),
                        );
                      }
                      return ButtonModel(
                        onTap: () {
                          Get.to(() => DriverInfo(driver: driver));
                        },
                        bus: true,
                        imgUrl: "img/st1.png",
                        padding: 10,
                        hMargin: width * 0.05,
                        vMargin: height * 0.02,
                        height: height * 0.08,
                        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                        backColor: const Color.fromARGB(255, 113, 65, 146),
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.05),
                        content: '${driver.fName} ${driver.lName}',
                      );
                    },
                    defaultChild:
                        const Center(child: CircularProgressIndicator()),
                  ),
                )),
            // SingleChildScrollView(
            //   physics: const BouncingScrollPhysics(),
            //   child: Container(
            //     height: height * 0.7,
            //     padding: EdgeInsets.only(top: height * 0.05),
            //     child: ListView.builder(
            //       itemCount: drivers.length,
            //       itemBuilder: (context, i) {
            //         return ButtonModel(
            //             onTap: () {
            //               Get.to(() => DriverInfo(driver: drivers[i]));
            //             },
            //             busName: drivers[i]["busName"]!,
            //             bus: true,
            //             imgUrl: drivers[i]['img']!,
            //             padding: 10,
            //             hMargin: width * 0.05,
            //             vMargin: height * 0.02,
            //             height: height * 0.08,
            //             rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             backColor: const Color.fromARGB(255, 113, 65, 146),
            //             style: TextStyle(
            //                 color: Colors.white, fontSize: width * 0.05),
            //             // textAlign: TextAlign.center,
            //             content: drivers[i]["name"]!);
            //       },
            //     ),
            //   ),
            // ),
            ButtonModel(
                onTap: () {
                  Get.to(() => const AddDriver());
                },
                padding: 10,
                hMargin: width * 0.05,
                vMargin: height * 0.02,
                height: height * 0.06,
                rowMainAxisAlignment: MainAxisAlignment.center,
                backColor: const Color.fromARGB(255, 113, 65, 146),
                style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                content: "اضافة سائق جديد")
          ],
        ),
      ),
    );
  }
}

List<Map<String, String>> drivers = [
  {
    "name": "احمد سعيد",
    "img": "img/img.png",
    "busName": "B1",
  },
  {
    "name": "سعد عبدالله",
    "img": "img/img2.png",
    "busName": "C1",
  },
];
