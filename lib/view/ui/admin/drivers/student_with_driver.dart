import 'package:flutter/material.dart';

import '../../widget/button_model.dart';

class StudentWithBusName extends StatelessWidget {
  const StudentWithBusName({super.key});

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
          title: const Text("B1"),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: height * 0.7,
                padding: EdgeInsets.only(top: height * 0.05),
                child: ListView.builder(
                  itemCount: drivers.length,
                  itemBuilder: (context, i) {
                    return ButtonModel(
                        onTap: () {
                          // Get.to(() => DriverInfo(driver: drivers[i]));
                        },
                        busName: drivers[i]["busName"]!,
                        bus: true,
                        imgPath: drivers[i]['img']!,
                        padding: 10,
                        hMargin: width * 0.05,
                        vMargin: height * 0.02,
                        height: height * 0.08,
                        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                        backColor: const Color.fromARGB(255, 113, 65, 146),
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.05),
                        // textAlign: TextAlign.center,
                        content: drivers[i]["name"]!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, String>> drivers = [
  {
    "name": "ساره عبد العزيز",
    "img": "img/student1.png",
    "busName": "B1",
  },
  {
    "name": "احمد خالد",
    "img": "img/student2.png",
    "busName": "B1",
  },
];
