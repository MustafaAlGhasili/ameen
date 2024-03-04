import 'package:ameen/view/ui/sign/signup_widgets.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/sign_controller.dart';


SignController controller = Get.find();

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    padding: EdgeInsets.only(top: height * 0.035),
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
                      return const Parent();
                    } else if (controller.step.value == 1) {
                      return const Student();
                    } else if (controller.step.value == 2) {
                      return const School();
                    } else if(controller.step.value == 3) {
                      return const UploadImage();
                    }else {
                      return const PrivacyTerms();                    }
                  },
                ),
              ),
            ),
          ),
        ));
  }
}

