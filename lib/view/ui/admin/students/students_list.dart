import 'package:ameen/view/ui/admin/drivers/add_driver.dart';
import 'package:ameen/view/ui/admin/students/student_info.dart';
import 'package:ameen/view/ui/admin/students/waiting_list.dart';
import 'package:ameen/view/ui/home/student_info.dart';

import '../../widget/button_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class StudentsList extends StatelessWidget {
  const StudentsList({super.key});

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
            "قائمة الطلاب",
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
                height: height * 0.7,
                padding: EdgeInsets.only(top: height * 0.05),
                child: ListView.builder(
                  itemCount: student.length,
                  itemBuilder: (context, i) {
                    return ButtonModel(
                        onTap: () {
                          Get.to(() => StudentDetails(
                                student: student[i],
                              ));
                        },
                        busName: student[i]["busName"]!,
                        bus: true,
                        imgPath: student[i]['img']!,
                        padding: 10,
                        hMargin: width * 0.05,
                        vMargin: height * 0.02,
                        height: height * 0.08,
                        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                        backColor: const Color.fromARGB(255, 113, 65, 146),
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.05),
                        // textAlign: TextAlign.center,
                        content: student[i]["name"]!);
                  },
                ),
              ),
            ),
            ButtonModel(
                onTap: () {
                  Get.to(() => const WaitingList());
                },
                padding: 10,
                hMargin: width * 0.05,
                vMargin: height * 0.02,
                height: height * 0.06,
                rowMainAxisAlignment: MainAxisAlignment.center,
                backColor: const Color.fromARGB(255, 113, 65, 146),
                style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                content: "قائمة الانتظار")
          ],
        ),
      ),
    );
  }
}

List<Map<String, String>> student = [
  {
    "name": "محمد عاصم",
    "img": "img/st1.png",
    "busName": "B1",
  },
  {
    "name": "احمد خالد",
    "img": "img/st2.png",
    "busName": "C1",
  },
];
