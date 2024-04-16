import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/student.dart';
import '../../../../utils/DatabaseHelper.dart';
import '../../widget/button_model.dart';
import '../students/student_info.dart';

class StudentWithBusName extends StatelessWidget {
  final String busId;

  const StudentWithBusName({super.key, required this.busId});

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
          title: Text(busId),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: height * 0.7,
                padding: EdgeInsets.only(top: height * 0.035),
                child: FirebaseAnimatedList(
                  physics: const BouncingScrollPhysics(),
                  query: DatabaseHelper.studentsRef
                      .orderByChild('busId')
                      .equalTo(busId),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    StudentModel student = StudentModel.fromSnapshot(snapshot);
                    print("object ${snapshot.exists}");
                    if(snapshot.exists == false){
                      return const Center(
                        child: Text("No student found"),
                      );
                    }else {
                      return ButtonModel(
                      onTap: () {
                        Get.to(() => StudentDetails(student: student, no: 0));
                      },
                      busName: student.busId ?? student.schoolId,
                      bus: true,
                      imgUrl:student.imgUrl!,
                      padding: 7,
                      hMargin: width * 0.05,
                      vMargin: height * 0.02,
                      height: height * 0.085,
                      rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                      backColor: const Color.fromARGB(255, 113, 65, 146),
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.05),
                      content: '${student.fName} ${student.lName}',
                    );
                    }
                  },
                  defaultChild:
                      const Center(child: CircularProgressIndicator()),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

