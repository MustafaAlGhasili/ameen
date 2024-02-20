import 'package:ameen/view/ui/sign/email_verification.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../widget/text_field.dart';
import '../../../controller/sign_controller.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    SignController controller = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 113, 65, 146),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(top: height * 0.03),
                  height: height * 0.35,
                  width: width,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 113, 65, 146),
                      image: DecorationImage(
                        image: AssetImage("img/logo.png"),
                      ))),
              Container(
                  height: height * 0.55,
                  margin: EdgeInsets.only(top: height * 0.45),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "نسيت كلمه المرور؟",
                        style: TextStyle(fontSize: height * 0.033),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      TextFieldModel(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          controller.forgetPassword = value;
                          print(controller.forgetPassword);
                        },
                        obscureText: false,
                        hint: "البريد الاكتروني",
                        label: "البريد الاكتروني",
                        sufIcon: const Icon(IconlyLight.message),
                        height: height * 0.07,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      ButtonModel(
                        onTap: () {
                          if (controller.forgetPassword.isEmpty) {
                            Get.showSnackbar(const GetSnackBar(
                              title: "Error",
                              message: "Please enter the email",
                              duration: Duration(seconds: 2),
                              animationDuration: Duration(milliseconds: 600),
                            ));
                          }else if(!controller.forgetPassword.contains("@")){
                            Get.showSnackbar(const GetSnackBar(
                              title: "Error",
                              message: "Invalid Email",
                              duration: Duration(seconds: 2),
                              animationDuration: Duration(milliseconds: 600),
                            ));
                          }else {
                            Get.showSnackbar(const GetSnackBar(
                              title: "Done",
                              message: "We Sent email verification to your email",
                              duration: Duration(seconds: 2),
                              animationDuration: Duration(milliseconds: 600),
                            ));
                            Get.to(const EmailVerification());
                          }
                        },
                        backColor: const Color.fromARGB(255, 113, 65, 146),
                        content: "ارسل",
                        width: width * 0.9,
                        height: height * 0.06,
                        style: TextStyle(
                            color: Colors.white, fontSize: height * 0.025),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
