import 'package:ameen/model/student.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/home/home_widgets/home.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/parent.dart';
import '../../../services/LocalStorageService.dart';
import 'edit_data.dart';

StudentModel? student;
ParentModel? parent;

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          centerTitle: true,
          title: const Text("المعلومات الشخصية"),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height * 1.8,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ButtonModel(
                      onTap: () => Get.to(() => Edit(
                            no: 0,
                            student: student,
                          )),
                      textAlign: TextAlign.center,
                      content: 'تعديل',
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      vMargin: height * 0.015,
                      height: height * 0.05,
                      backColor: PRIMARY_COLOR,
                      width: width * 0.2,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: height * 0.01,
                    // width: width * 0.,

                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: height * 0.015),
                    child: Text("معلومات الطالب",
                        style: TextStyle(fontSize: width * 0.05)),
                  ),
                  const StudentInfo(),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ButtonModel(
                      onTap: () => Get.off(() => Edit(
                            no: 1,
                            parent: parent,
                          )),
                      textAlign: TextAlign.center,
                      content: 'تعديل',
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      vMargin: height * 0.015,
                      height: height * 0.05,
                      backColor: PRIMARY_COLOR,
                      width: width * 0.2,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: height * 0.01,
                    // width: width * 0.,

                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: height * 0.015),
                    child: Text("معلومات ولي الامر",
                        style: TextStyle(fontSize: width * 0.05)),
                  ),
                  const ParentInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<StudentModel?>(
      future: LocalStorageService.getStudent(),
      builder: (context, snapshot) {
        student = snapshot.data;
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
              Container(
                padding: EdgeInsets.all(width * 0.035),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(student!.fName),
              ),
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
              Container(
                padding: EdgeInsets.all(width * 0.035),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(student!.lName),
              ),
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
              Container(
                padding: EdgeInsets.all(width * 0.035),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(student!.nationalId),
              ),
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
              Container(
                padding: EdgeInsets.all(width * 0.035),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(student!.phone),
              ),
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
              Container(
                padding: EdgeInsets.all(width * 0.035),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(student!.email),
              ),
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
              Container(
                padding: EdgeInsets.all(width * 0.035),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(student!.blood),
              ),
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
              Container(
                padding: EdgeInsets.all(width * 0.035),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text("${student!.busId}"),
              ),
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

class ParentInfo extends StatefulWidget {
  const ParentInfo({super.key});

  @override
  State<ParentInfo> createState() => _ParentInfoState();
}

class _ParentInfoState extends State<ParentInfo> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder<ParentModel?>(
      future: LocalStorageService.getParent(),
      builder: (context, snapshot) {
        parent = snapshot.data;
        // print("parent ${parent!.fName}");
        // print(parent!.fName);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          delay();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("الاسم الاول"),
              ),
              Container(
                padding: const EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parent!.fName),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("الاسم الاخير"),
              ),
              Container(
                padding: const EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parent!.lName),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("رقم الأحوال"),
              ),
              Container(
                padding: const EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parent!.nationalId),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("رقم التواصل "),
              ),
              Container(
                padding: const EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parent!.phone),
              ),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Text("تاريخ الميلاد"),
              // ),
              // Container(
              //   padding: const EdgeInsets.all(13),
              //   width: width,
              //   height: height * 0.06,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       border: Border.all(color: Colors.black)),
              //   child: Text(parent!.email),
              // ),
              SizedBox(
                height: height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("البريد الالكتروني"),
              ),
              Container(
                padding: const EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parent!.email),
              ),
            ],
          );
        } else {
          return Container(
            color: Colors.blue,
            height: 100,
          );
        }
      },
    );
  }

  void delay() async {
    Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }
}
