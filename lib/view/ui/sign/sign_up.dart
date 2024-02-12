import 'package:ameen/view/ui/sign/student_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/button_model.dart';
import '../widget/text_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size(width, height * 0.1),
              child: Container(
                color: Colors.black,
                child: AppBar(
                  bottom: const PreferredSize(
                    preferredSize: Size(100, 200),
                    child: Text(""),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Column(
                children: [
                  Text("معلومات ولي الأمر",
                      style: TextStyle(fontSize: width * 0.07)),
                  TextFieldModel(

                    text: "الاسم الاول",
                    height: height * 0.06,
                    obscureText: false,
                  ),
                  TextFieldModel(
                    text: "الاسم الأخير",
                    height: height * 0.06,
                    obscureText: false,
                  ),
                  TextFieldModel(
                    text: "رقم الاحوال",
                    height: height * 0.06,
                    obscureText: false,
                  ),
                  TextFieldModel(
                    text: "رقم التواصل",
                    height: height * 0.06,
                    obscureText: false,
                  ),
                  TextFieldModel(
                    text: "ادخل كلمة السر",
                    height: height * 0.06,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: height * 0.09,
                  ),
                  ButtonModel(
                    onTap: () {
                      Get.to(() => const StudentInfo());
                    },
                    width: width * 0.9,
                    content: 'التالي',
                    backColor: const Color.fromARGB(255, 113, 65, 146),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.05,
                    ),
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
