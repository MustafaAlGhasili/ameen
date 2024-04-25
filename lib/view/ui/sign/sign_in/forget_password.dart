import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../controller/sign_controller.dart';
import '../../widget/text_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
      Get.lazyPut(() => SignController());

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
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: height * 0.01,
                  ),
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
                        "إستعادة كلمة المرور",
                        style: TextStyle(fontSize: height * 0.033),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      TextFieldModel(
                        onChanged: (val) {
                          controller.signInEmailCont = val;
                        },
                        obscureText: false,
                        hint: "البريد الاكتروني",
                        text: "البريد الاكتروني",
                        sufIcon: const Icon(IconlyLight.profile),
                        vPadding: height * 0.03,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Obx(
                        () => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  final result = await controller.resetPassword(
                                    controller.signInEmailCont!,
                                  );
                                  print("result is $result");
                                  if (result) {
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
                              'إستعادة',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.05,
                              ),
                            ),
                          ),
                        ),
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
