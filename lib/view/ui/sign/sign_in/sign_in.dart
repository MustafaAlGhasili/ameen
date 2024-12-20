import 'package:Amin/controller/camera_controller.dart';
import 'package:Amin/view/ui/admin/admin_home.dart';
import 'package:Amin/view/ui/driver/driver_home.dart';
import 'package:Amin/view/ui/sign/sign_in/forget_password.dart';
import 'package:Amin/view/ui/sign/sign_up/sign_up.dart';
import 'package:Amin/view/ui/widget/button_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../controller/sign_controller.dart';
import '../../../../services/LocalStorageService.dart';
import '../../home/home.dart';
import '../../widget/text_field.dart';

class SignIn extends StatelessWidget {
  final int? loginType;

  const SignIn({super.key, this.loginType});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    LocalStorageService.saveTrip(null);

    print("User Type:$loginType");
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
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          controller.signInEmailCont = val;
                        },
                        obscureText: false,
                        text: "البريد الاكتروني",
                        sufIcon: const Icon(IconlyLight.profile),
                        vPadding: height * 0.03,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Obx(
                          () => TextFieldModel(
                              onChanged: (val) {
                                controller.signInPassCont = val;
                              },
                              obscureText: !controller.visibility.value,
                              text: "كلمة السر",
                              vPadding: height * 0.03,
                              sufIcon: controller.visibility.value
                                  ? IconButton(
                                      icon:
                                          const Icon(Icons.visibility_outlined),
                                      onPressed: controller.changeVisibility,
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                          Icons.visibility_off_outlined),
                                      onPressed: controller.changeVisibility,
                                    )),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Obx(
                        () => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  final result = await controller
                                      .signInWithEmailAndPassword(
                                          controller.signInEmailCont!.trim(),
                                          controller.signInPassCont!,
                                          loginType!);
                                  print("result is $result");
                                  if (result) {
                                    switch (loginType) {
                                      case 0:
                                        Get.offAll(() => const Home());
                                        break;
                                      case 1:
                                        Get.offAll(() => const DriverHome());
                                        break;
                                      case 2:
                                        Get.offAll(() => const AdminHome());
                                        break;
                                      default:
                                        break;
                                    }
                                    controller.isLoading(false);
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
                                        title: "خطأ",
                                        message:
                                            controller.loginErrorValue.value,
                                        duration: const Duration(seconds: 2),
                                        animationDuration:
                                            const Duration(milliseconds: 600),
                                      ),
                                    );
                                    controller.isLoading(false);
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 113, 65, 146),
                            minimumSize: Size(width * 0.9, height * 0.065),
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
                            Visibility(
                              visible: loginType == 0,
                              child: ButtonModel(
                                padding: 10,
                                onTap: () {
                                  Get.lazyPut(() => CamController());
                                  Get.to(() => const SignUp());
                                },
                                content: "تسجيل جديد",
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                            ),
                            ButtonModel(
                              onTap: () {
                                Get.to(() => const ForgetPassword());
                              },
                              content: "نسيت كلمه المرور؟",
                              style: TextStyle(fontSize: height * 0.02),
                            ),
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
