import 'package:ameen/view/ui/admin/students/waiting_student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/button_model.dart';

class WaitingList extends StatelessWidget {
  const WaitingList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("قائمة انتظار"),
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: height * 0.5,
              child: ListView.builder(
                itemCount: student.length,
                itemBuilder: (context, i) {
                  return ButtonModel(
                      onTap: () {
                        Get.to(() => WaitingStudent(
                              student: student[i],
                            ));
                      },
                      bus: false,
                      imgPath: student[i]['img']!,
                      padding: 10,
                      hMargin: width * 0.05,
                      vMargin: height * 0.02,
                      height: height * 0.085,
                      rowMainAxisAlignment: MainAxisAlignment.start,
                      backColor: const Color.fromARGB(255, 113, 65, 146),
                      contentPdding: 10,
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.05),
                      // textAlign: TextAlign.center,
                      content: student[i]["name"]!);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Map<String, String>> student = [
  {
    "name": "هند محمد",
    "img": "img/student1.png",
  },
];
