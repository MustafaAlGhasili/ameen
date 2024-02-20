import 'package:ameen/view/ui/sign/email_verification.dart';
import 'package:ameen/view/ui/sign/sign_up.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:ameen/view/ui/sign/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../widget/text_field.dart';
import '../../../controller/sign_controller.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
                        alignment: Alignment.center,
                        image: AssetImage("img/logo.png"),
                      ))),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: height * 0.55,
                  margin: EdgeInsets.only(top: height * 0.45),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "تسجيل الدخول",
                        style: TextStyle(fontSize: height * 0.033),
                      ),
                      TextFieldModel(
                        controller: controller.signInEmailCont,
                        obscureText: false,
                        hint: "البريد الاكتروني",
                        label: "البريد الاكتروني",
                        sufIcon: const Icon(IconlyLight.profile),
                        height: height * 0.07,
                      ),
                      Obx(
                        () => TextFieldModel(
                            controller: controller.signInPassCont,
                            obscureText: controller.visibility.value,
                            hint: "كلمة السر",
                            label: "كلمة السر",
                            height: height * 0.07,
                            sufIcon: controller.visibility.value
                                ? IconButton(
                                    icon: const Icon(Icons.visibility_outlined),
                                    onPressed: controller.changeVisibility,
                                  )
                                : IconButton(
                                    icon: const Icon(
                                        Icons.visibility_off_outlined),
                                    onPressed: controller.changeVisibility,
                                  )),
                      ),
                      SizedBox(height: height * 0.02),
                      ButtonModel(
                        onTap: () {
                          if (controller.signInPassCont.text.isEmpty) {
                            Get.showSnackbar(const GetSnackBar(
                              title: "Error",
                              message: "Please enter the password",
                              duration: Duration(seconds: 2),
                              animationDuration: Duration(milliseconds: 600),
                            ));
                          }
                        },
                        backColor: const Color.fromARGB(255, 113, 65, 146),
                        content: "تسجيل الدخول",
                        width: width * 0.9,
                        height: height * 0.06,
                        style: TextStyle(
                            color: Colors.white, fontSize: height * 0.025),
                      ),
                      SizedBox(
                        width: width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonModel(
                                onTap: () {
                                  Get.to(() => const SignUp());
                                },
                                content: "تسجيل جديد",
                                style: TextStyle(fontSize: height * 0.02)),
                            ButtonModel(
                                onTap: () {
                                  Get.to(
                                    () => const ForgetPassword(),
                                  );
                                },
                                content: "نسيت كلمه المرور؟",
                                style: TextStyle(fontSize: height * 0.02)),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
