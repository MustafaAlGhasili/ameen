import 'dart:convert';

import 'package:ameen/model/driver.dart';
import 'package:ameen/model/student.dart';
import 'package:ameen/services/LocalStorageService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/parent.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final getParent = LocalStorageService.getParent();

    ParentModel? parentModel;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          centerTitle: true,
          title: const Text("معلومات الطالب"),
        ),
        body: SizedBox(
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: FutureBuilder<ParentModel?>(
                future: getParent,
                builder: (context, snapshot) {
                  parentModel = snapshot.data;
                  print("parent $parentModel");
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: const Text("الاسم الاول"),
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
                          child: Text(parentModel!.phone),
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
                          child: Text(parentModel!.fName),
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
                          child: Text(parentModel!.id),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      height: 300,
                      color: Colors.red,
                      child: Text(
                        "$parentModel",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
