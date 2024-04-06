import 'package:ameen/view/ui/admin/students/waiting_student.dart';
import 'package:ameen/view/ui/sign/sign_up/student_sign.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/student.dart';
import '../../../../utils/DatabaseHelper.dart';
import '../../widget/button_model.dart';

class WaitingList extends StatelessWidget {
  const WaitingList({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper dbHelper = DatabaseHelper();

  

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
        body: FutureBuilder(
          future: dbHelper.getStudentsParentsByStatus(false),
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
                      Get.to(() => WaitingStudent(student: student[i]));
                    },
                    bus: true,
                    imgUrl: "img/st1.png",
                    padding: 10,
                    hMargin: width * 0.05,
                    vMargin: height * 0.02,
                    height: height * 0.08,
                    rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                    backColor: const Color.fromARGB(255, 113, 65, 146),
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.05),
                    content: '${student![i].fName} ${student[i].lName}',
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }
}
