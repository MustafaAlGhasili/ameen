import 'package:ameen/view/ui/admin/students/student_info.dart';
import 'package:ameen/view/ui/admin/students/waiting_list.dart';
import 'package:ameen/view/ui/home/info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../model/student.dart';
import '../../../../utils/DatabaseHelper.dart';
import '../../widget/button_model.dart';

class StudentsList extends StatelessWidget {
  const StudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    DatabaseHelper dbHelper = DatabaseHelper();
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
            Container(
                height: height * 0.75,
                padding: EdgeInsets.only(top: height * 0.05),
                child: FutureBuilder(
                  future: dbHelper.getStudentsOfEnabledParents(),
                  builder: (context, snapshot) {
                    final student = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, i) {
                          return ButtonModel(
                            onTap: () {
                              Get.to(() => StudentDetails(
                                    student: student[i],
                                no: 0,
                                  ));
                            },
                            bus: true,
                            imgUrl: "img/st1.png",
                            padding: 10,
                            hMargin: width * 0.05,
                            vMargin: height * 0.02,
                            height: height * 0.08,
                            rowMainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            backColor: const Color.fromARGB(255, 113, 65, 146),
                            style: TextStyle(
                                color: Colors.white, fontSize: width * 0.05),
                            content: '${student![i].fName} ${student[i].lName}',
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                )),
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
                content: "قائمة الانتظار"),
          ],
        ),
      ),
    );
  }
}
