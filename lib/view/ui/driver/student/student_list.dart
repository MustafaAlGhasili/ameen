import 'package:Amin/model/student.dart';
import 'package:Amin/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/DatabaseHelper.dart';
import '../../admin/students/student_info.dart';

class StudentList extends StatelessWidget {
  final String busId;

  const StudentList({super.key, required this.busId});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper dbHelper = DatabaseHelper();
    Future<List<StudentModel>>? studentList;

    studentList = dbHelper.getStudentsByBusId(busId);

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
              final student = snapshot.data;
              print(student);
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
              } else if (student!.isEmpty) {
                return const Center(
                  child: Text("No student found"),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
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
                              radius: width * 0.09,
                              child: CachedNetworkImage(
                                imageUrl: student[i].imgUrl ?? " ",
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Image(
                                        image: AssetImage("img/st1.png")),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.015,
                          ),
                          Text(
                            "${student[i].fName} ${student[i].lName}",
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
