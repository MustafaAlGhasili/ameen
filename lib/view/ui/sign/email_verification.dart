import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../controller/sign_controller.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    SignController controller = Get.find();

    return Directionality(
      textDirection: TextDirection.ltr,
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
                        "ادخل كلمة التحقق",
                        style: TextStyle(fontSize: height * 0.033),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.06),
                          child: PinCodeTextField(
                            controller: controller.emailVerificationCont,
                            appContext: context,
                            pastedTextStyle: const TextStyle(
                              color: Color.fromARGB(255, 113, 65, 146),
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: false,
                            obscuringCharacter: '*',
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              selectedColor:
                                  const Color.fromARGB(255, 113, 65, 146),
                              errorBorderColor: Colors.yellow,
                              disabledColor: Colors.pink,
                              inactiveColor: Colors.grey,
                              inactiveFillColor: Colors.black,
                              selectedFillColor: Colors.indigo,
                              activeColor:
                                  const Color.fromARGB(255, 113, 65, 146),
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 60,
                              fieldWidth: 50,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            textStyle:
                                const TextStyle(fontSize: 20, height: 1.6),

                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              controller.code = value;
                            },
                            onCompleted: (v) async {
                              Get.dialog(
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                )
                              );
                              await Future.delayed(const Duration(seconds: 2));

                              if (v == '123456') {
                               Navigator.of(Get.overlayContext!).pop();
                                Get.showSnackbar(const GetSnackBar(
                                  title: "Good",
                                  message: "Go ahead",
                                  icon: Icon(Icons.account_circle),
                                  duration: Duration(seconds: 2),
                                ));
                              }else {
                                Navigator.of(Get.overlayContext!).pop();
                                controller.emailVerificationCont.text = '';
                                Get.showSnackbar(const GetSnackBar(
                                  title: "Error",
                                  message: "Try Again",
                                  icon: Icon(Icons.error_outline),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                      GestureDetector(
                        onTap: () {},
                        child: Text("اعادة ارسال الرمز؟",
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: width * 0.045)),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      ButtonModel(
                        onTap: () {
                          if(controller.code.isEmpty){
                            Get.showSnackbar(const GetSnackBar(
                              title: "sljn",
                              message: "sjkcn",
                              icon: Icon(Icons.error_outline),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        },
                        backColor: const Color.fromARGB(255, 113, 65, 146),
                        content: "تاكيد",
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
