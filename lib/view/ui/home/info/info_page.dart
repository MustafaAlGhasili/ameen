import 'package:ameen/controller/home_controller.dart';
import 'package:ameen/model/student.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/home/home.dart';
import 'package:ameen/view/ui/home/info/parent_info.dart';
import 'package:ameen/view/ui/home/info/student_info.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../model/parent.dart';
import '../edit_data/edit_data.dart';

StudentModel? student;
ParentModel? parent;

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    HomeController controller = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.off(const Home(index: 2));
              },
              icon: const Icon(Icons.arrow_back)),
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          centerTitle: true,
          title: const Text("المعلومات الشخصية"),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height * 1.9,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ButtonModel(
                      onTap: () => Get.off(() => EditPage(
                            no: 0,
                            student: controller.studentData,
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
                      onTap: () => Get.off(() => EditPage(
                            no: 1,
                            parent: controller.parentData,
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
