import 'package:ameen/controller/home_controller.dart';
import 'package:ameen/model/student.dart';
import 'package:flutter/material.dart';
import '../../../../services/LocalStorageService.dart';
import '../../widget/custom_container.dart';
import 'package:get/get.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    StudentModel? student;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<StudentModel?>(
      future: LocalStorageService.getStudent(),
      builder: (context, snapshot) {
        student = snapshot.data;
        controller.studentData = student!;

        print("erro ${snapshot.error}");
        print("connectionState ${snapshot.connectionState}");
        print("studentModel ${snapshot.data}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text("الاسم الاول",
                    style: TextStyle(fontSize: width * 0.04)),
              ),
              CustomContainer(text: student!.fName),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "الاسم الاخير",
                  style: TextStyle(fontSize: width * 0.04),
                ),
              ),
              CustomContainer(text: student!.lName),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "رقم الأحوال",
                  style: TextStyle(fontSize: width * 0.04),
                ),
              ),
              CustomContainer(text: student!.nationalId),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "رقم التواصل ",
                  style: TextStyle(fontSize: width * 0.04),
                ),
              ),
              CustomContainer(text: student!.phone),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "البريد الإلكتروني",
                  style: TextStyle(fontSize: width * 0.04),
                ),
              ),
              CustomContainer(text: student!.email),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "فصيلة الدم ",
                  style: TextStyle(fontSize: width * 0.04),
                ),
              ),
              CustomContainer(text: student!.blood),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "رقم الباص ",
                  style: TextStyle(fontSize: width * 0.04),
                ),
              ),
              CustomContainer(text: "${student!.busId}"),
            ],
          );
        } else {
          return Container(
            height: 100,
            color: Colors.red,
          );
        }
      },
    );
  }
}
