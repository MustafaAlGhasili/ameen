import 'package:ameen/model/student.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/widget/cusom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widget/button_model.dart';

class StudentDetails extends StatelessWidget {
  final StudentModel student;

  const StudentDetails({super.key, required this.student});

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
          title: const Text("معلومات الطالب"),
          centerTitle: true,
        ),
        body: SizedBox(
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.035),
                    child: Container(
                      margin: EdgeInsets.only(right: width * 0.27),
                      height: height * 0.15,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          border: Border.all(
                              color: const Color.fromARGB(255, 113, 65, 146))),
                      child: Image(
                        width: width * 0.27,
                        image: AssetImage('img/img.png'),
                      ),
                    ),
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
                    child: Text(student.fName),
                  ),
                  SizedBox(
                    height: height * 0.025,
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
                    child: Text(student.lName),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("الصف"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Text("${student.grade}"),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("فصيلة الدم"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Text(student.blood),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("رقم ولي الامر"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Text(student.parentId),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  ButtonModel(
                    onTap: () =>
                        _launchUrl(student.latitude, student.longitude),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: width * 0.045,
                    ),
                    content: "موقع المنزل",
                    textAlign: TextAlign.center,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                  ),
                  ButtonModel(
                    onTap: () {

                      Get.dialog(const CustomDialog(

                          buttonText: "نعم",
                          content: "هل متأكد من ازاله الطالب؟"));
                    },
                    vMargin: height * 0.01,
                    height: height * 0.073,
                    backColor: Colors.red,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.045,
                    ),
                    content: "إزاله الطالب",
                    textAlign: TextAlign.center,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _launchUrl(final latitude, final longitude) async {
  final Uri _googleMapUrl =
      Uri.parse("https://www.google.com/maps/@$latitude,$longitude,15z");
  if (!await launchUrl(_googleMapUrl)) {
    throw Exception('Could not launch $_googleMapUrl');
  } else {
    launchUrl(_googleMapUrl);
  }
}
