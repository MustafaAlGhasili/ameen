import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../controller/controller.dart';
import '../widget/button_model.dart';
import '../widget/text_field.dart';

SignController controller = Get.find();

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Obx(
            () => SizedBox(
              height: height,
              width: width,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(width, height * 0.1),
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: SizedBox(
                      width: width,
                      child: EasyStepper(
                        activeStep: controller.step.value,
                        activeStepTextColor: Colors.black87,
                        finishedStepTextColor: Colors.black87,
                        internalPadding: 0,
                        showLoadingAnimation: false,
                        stepRadius: width * 0.05,
                        showStepBorder: false,
                        stepBorderRadius: 0,
                        finishedStepBackgroundColor:
                            Colors.black.withOpacity(0),
                        steps: [
                          EasyStep(
                            customStep: CircleAvatar(
                              radius: 7,
                              backgroundColor: controller.step.value >= 0
                                  ? const Color.fromARGB(255, 113, 65, 146)
                                  : Colors.purple[100],
                            ),
                            title: 'ولي الامر',
                          ),
                          EasyStep(
                            // customLineWidget: ,
                            customStep: CircleAvatar(
                              radius: 7,
                              backgroundColor: controller.step.value >= 1
                                  ? const Color.fromARGB(255, 113, 65, 146)
                                  : Colors.purple[300],
                            ),
                            title: 'الطالب',
                            // topTitle: fasle,
                          ),
                          EasyStep(
                            customStep: CircleAvatar(
                              radius: 7,
                              backgroundColor: controller.step.value >= 2
                                  ? const Color.fromARGB(255, 113, 65, 146)
                                  : Colors.purple[200],
                            ),
                            title: 'المدرسة',
                          ),
                          EasyStep(
                            customStep: CircleAvatar(
                              radius: 7,
                              backgroundColor: controller.step.value >= 3
                                  ? const Color.fromARGB(255, 113, 65, 146)
                                  : Colors.purple[100],
                            ),
                            customTitle: Text(
                              "رفع صورة الوجه",
                              style: TextStyle(
                                height: 1,
                                fontSize: 12,
                                color: controller.step.value >= 3
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          EasyStep(
                            customStep: CircleAvatar(
                              radius: 7,
                              backgroundColor: controller.step.value >= 4
                                  ? const Color.fromARGB(255, 113, 65, 146)
                                  : Colors.purple[50],
                            ),
                            customTitle: Text(
                              textAlign: TextAlign.center,
                              "الشروط والاحكام",
                              style: TextStyle(
                                height: 1,
                                fontSize: 11,
                                color: controller.step.value >= 4
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            // title: 'الشروط والاحكام',
                          ),
                        ],
                        onStepReached: (index) => controller.step.value = index,
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                body: Builder(
                  builder: (context) {
                    if (controller.step.value == 0) {
                      return Parent();
                    } else {
                      return Text("scjsj");
                    }
                  },
                ),
              ),
            ),
          ),
        ));
  }
}

class Parent extends StatelessWidget {
  const Parent({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Padding(
      padding: EdgeInsets.all(width * 0.03),
      child: Column(
        children: [
          Text("معلومات ولي الأمر", style: TextStyle(fontSize: width * 0.07)),
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
              controller.step.value++;
              // Get.to(() => const StudentInfo());
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
    );
  }
}

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;

    SignController controller = Get.find();
    return SingleChildScrollView(
      child: SizedBox(
        // width: width,
        height: height,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Column(
                children: [
                  Text("معلومات الطالب",
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
                    sufIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(IconlyLight.calendar)),
                    text: "تاريخ الميلاد",
                    height: height * 0.06,
                    obscureText: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DropdownMenu(
                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                              value: "sckn",
                              label: "Sckm",
                            )
                          ],
                          hintText: "فصيلة الدم",
                          menuStyle: MenuStyle(
                            shape: MaterialStatePropertyAll(
                                ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)))),
                          ),
                        ),
                        DropdownButton(
                            items: blood
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text("$e"),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              controller.password = value as String?;
                              print(controller.password);
                              controller.update();
                            },
                            value: controller.password),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  ButtonModel(
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

List blood = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'];
