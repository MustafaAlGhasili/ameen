import 'package:ameen/view/ui/sign/sign_in/forget_password.dart';
import 'package:ameen/view/ui/sign/sign_up/sign_up.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../controller/sign_controller.dart';
import '../../home/home.dart';
import '../../widget/text_field.dart';

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
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
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
                        text: "البريد الاكتروني",
                        sufIcon: const Icon(IconlyLight.profile),
                        vPadding: height * 0.03,
                      ),
                      Obx(
                        () => TextFieldModel(
                            controller: controller.signInPassCont,
                            obscureText: controller.visibility.value,
                            hint: "كلمة السر",
                            text: "كلمة السر",
                            vPadding: height * 0.03,
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
                      Obx(
                        () => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  final result = await controller
                                      .signInWithEmailAndPassword(
                                          controller.signInEmailCont.text,
                                          controller.signInPassCont.text);
                                  print("result is $result");
                                  if (result) {
                                    Get.offAll(() => const Home());
                                  } else {
                                    Get.showSnackbar(
                                      GetSnackBar(
                                        borderRadius: 20,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: width * 0.045,
                                            vertical: height * 0.015),
                                        icon: Icon(
                                          IconlyLight.info_circle,
                                          color: Colors.white,
                                          size: width * 0.065,
                                        ),
                                        title: "Error",
                                        message:
                                            controller.loginErrorValue.value,
                                        duration: const Duration(seconds: 2),
                                        animationDuration:
                                            const Duration(milliseconds: 600),
                                      ),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 113, 65, 146),
                            minimumSize: Size(width * 0.9, height * 0.055),
                          ),
                          child: Visibility(
                            visible: !controller.isLoading.value,
                            replacement: const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.05,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonModel(
                                padding: 10,
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

  bool validateInputs(BuildContext context, double height, double width) {
    if (controller.signInEmailCont.text.isEmpty) {

      Get.showSnackbar(
        GetSnackBar(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.045, vertical: height * 0.015),
          icon: Icon(
            IconlyLight.info_circle,
            color: Colors.white,
            size: width * 0.065,
          ),
          title: "Error",
          message: "Please Enter the Email",
          duration: const Duration(seconds: 2),
          borderRadius: 20,
          animationDuration: const Duration(milliseconds: 600),
        ),
      );
      return false;
    } else if (controller.signInPassCont.text.isEmpty) {
      Get.showSnackbar(
        GetSnackBar(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.045, vertical: height * 0.015),
          icon: Icon(
            IconlyLight.info_circle,
            color: Colors.white,
            size: width * 0.065,
          ),
          borderRadius: 20,
          title: "Error",
          message: "Please Enter the Password",
          duration: const Duration(seconds: 2),
          animationDuration: const Duration(milliseconds: 600),
        ),
      );
      return false;
    } else if (!controller.signInEmailCont.text.contains('@')) {
      Get.showSnackbar(
        GetSnackBar(
          borderRadius: 20,
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.045, vertical: height * 0.015),
          icon: Icon(
            IconlyLight.info_circle,
            color: Colors.white,
            size: width * 0.065,
          ),
          title: "Error",
          message: "Invalid Email",
          duration: const Duration(seconds: 2),
          animationDuration: const Duration(milliseconds: 600),
        ),
      );

      return false;
    }
    return true;
  }
}
