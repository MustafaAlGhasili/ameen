import 'package:ameen/model/student.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/home/home_widgets.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:flutter/material.dart';
import '../../../model/parent.dart';

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
            height: height * 2,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ButtonModel(
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
      future: controller.studentShared(),
      builder: (context, snapshot) {
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
                child: Text(snapshot.data!.fName),
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
                child: Text(snapshot.data!.lName),
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
                child: Text(snapshot.data!.nationalId),
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
                child: Text(snapshot.data!.birthDate),
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
                child: Text(snapshot.data!.email),
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
                child: Text(snapshot.data!.blood),
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
                child: Text(snapshot.data!.id),
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

class ParentInfo extends StatelessWidget {
  const ParentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ParentModel? parentModel;
    return FutureBuilder<ParentModel?>(
      future: controller.parentShared(),
      builder: (context, snapshot) {
        parentModel = snapshot.data;
        // print("parent ${parentModel!.fName}");
        // print(parentModel!.fName);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text("الاسم"),
              ),
              Container(
                padding: EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parentModel!.fName),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text("الاسم الاخير"),
              ),
              Container(
                padding: EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parentModel!.lName),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text("رقم الأحوال"),
              ),
              Container(
                padding: EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parentModel!.nationalId),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text("رقم التواصل "),
              ),
              Container(
                padding: EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parentModel!.fName),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text("تاريخ الميلاد"),
              ),
              Container(
                padding: EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parentModel!.email),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text("فصيلة الدم "),
              ),
              Container(
                padding: EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parentModel!.id),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text("رقم الباص "),
              ),
              Container(
                padding: EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(parentModel!.phone),
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
}
