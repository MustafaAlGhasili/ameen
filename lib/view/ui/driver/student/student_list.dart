import 'package:ameen/model/student.dart';
import 'package:ameen/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/DatabaseHelper.dart';
import '../../admin/students/student_info.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  DatabaseHelper dbHelper = DatabaseHelper();
  Future<List<StudentModel>>? studentList;
  List<StudentModel>? retrievedStudentList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    studentList = dbHelper.getStudentsByBusId('B1');
    retrievedStudentList = await dbHelper.getStudentsByBusId('B1');
  }
  @override
  Widget build(BuildContext context) {
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
              print("slkndksv ${snapshot.data!}");

              return ListView.builder(
                itemCount: retrievedStudentList!.length,
                itemBuilder: (context, i) {


                  final student = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
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
                                radius:  width* 0.09,
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
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "${snapshot.error}",
                        style: TextStyle(fontSize: width * 0.05),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      "kkkkkk",
                      style: TextStyle(fontSize: width * 0.05),
                    ),
                  );;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

// List<String> student = ["احمد خالد", "ساره عبد العزيز"];
List<String> img = ['img/img.png', 'img/img2.png'];
