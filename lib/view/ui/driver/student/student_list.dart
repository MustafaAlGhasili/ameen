import 'package:ameen/model/student.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/driver/driver_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/DatabaseHelper.dart';
import '../../admin/students/student_info.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper dbHelper = DatabaseHelper();

    Future<List<StudentModel>>? studentList;

    studentList = dbHelper.getStudentsByBusId('AA');

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "قائمة الطلاب",
            style: TextStyle(
              fontSize: width * 0.065,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: height * 0.05),
          child: FutureBuilder<List<StudentModel>?>(
            future: studentList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: PRIMARY_COLOR,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  final student = snapshot.data;

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => StudentDetails(
                            student: student[i],
                            no: 1,
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.symmetric(
                          vertical: height * 0.015, horizontal: width * 0.05),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(img[i]),
                              radius: width * 0.09,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.015,
                          ),
                          Text(
                            student![i].fName,
                            style: TextStyle(
                              fontSize: width * 0.05,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}


List<String> img = ['img/img.png', 'img/img2.png'];