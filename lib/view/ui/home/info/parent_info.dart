import 'package:flutter/material.dart';
import '../../../../model/parent.dart';
import '../../../../services/LocalStorageService.dart';
import '../../widget/custom_container.dart';

class ParentInfo extends StatefulWidget {
  const ParentInfo({super.key});

  @override
  State<ParentInfo> createState() => _ParentInfoState();
}

class _ParentInfoState extends State<ParentInfo> {
  @override
  Widget build(BuildContext context) {
    ParentModel? parent;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder<ParentModel?>(
      future: LocalStorageService.getParent(),
      builder: (context, snapshot) {
        parent = snapshot.data;

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "الاسم الاول",
                  style: TextStyle(fontSize: width * 0.037),
                ),
              ),
              CustomContainer(text: parent!.fName),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "الاسم الاخير",
                  style: TextStyle(fontSize: width * 0.037),
                ),
              ),
              CustomContainer(text: parent!.lName),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "رقم الأحوال",
                  style: TextStyle(fontSize: width * 0.037),
                ),
              ),
              CustomContainer(text: parent!.nationalId),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "رقم التواصل ",
                  style: TextStyle(fontSize: width * 0.037),
                ),
              ),
              CustomContainer(text: parent!.phone),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                child: Text(
                  "البريد الالكتروني",
                  style: TextStyle(fontSize: width * 0.037),
                ),
              ),
              CustomContainer(text: parent!.email),
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
