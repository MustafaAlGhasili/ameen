import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../utils/DatabaseHelper.dart';
import '../../widget/button_model.dart';
import '../../widget/text_field.dart';
import 'sign_up.dart';

class Parent extends StatelessWidget {
  const Parent({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    DatabaseHelper _databaseHelper = DatabaseHelper();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.045, vertical: height * 0.04),
          child: Column(
            children: [
              Text("معلومات ولي الأمر",
                  style: TextStyle(fontSize: width * 0.07)),
              SizedBox(
                height: height * 0.035,
              ),
              TextFieldModel(
                controller: controller.parentFName,
                // vPadding: height * 0.035,
                keyboardType: TextInputType.name,
                text: "الاسم الاول",
              ),
              SizedBox(
                height: height * 0.035,
              ),
              TextFieldModel(
                controller: controller.parentLName,
                // vPadding: height * 0.035,
                keyboardType: TextInputType.name,
                text: "الاسم الأخير",
              ),
              SizedBox(
                height: height * 0.035,
              ),
              TextFieldModel(
                controller: controller.parentNationalId,
                // vPadding: height * 0.035,
                keyboardType: TextInputType.number,
                text: "رقم الاحوال",
              ),
              SizedBox(
                height: height * 0.035,
              ),
              TextFieldModel(
                controller: controller.parentPhone,
                // vPadding: height * 0.035,
                keyboardType: TextInputType.number,
                text: "رقم التواصل",
              ),
              SizedBox(
                height: height * 0.035,
              ),
              TextFieldModel(
                controller: controller.parentEmail,
                // vPadding: height * 0.035,
                keyboardType: TextInputType.emailAddress,
                text: "الإيميل",
              ),
              SizedBox(
                height: height * 0.035,
              ),
              Obx(() => TextFieldModel(
                text: "ادخل كلمة المرور",
                  sufIcon: controller.visibility.value
                      ? IconButton(
                          icon: const Icon(Icons.visibility_outlined),
                          onPressed: controller.changeVisibility,
                        )
                      : IconButton(
                          icon: const Icon(Icons.visibility_off_outlined),
                          onPressed: controller.changeVisibility,
                        ))),
              SizedBox(
                height: height * 0.05,
              ),
              ButtonModel(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    controller.step.value++;
                  }
                  // Get.to(() => const StudentInfo());
                },
                height: height * 0.06,
                width: width * 0.9,
                content: 'التالي',
                rowMainAxisAlignment: MainAxisAlignment.center,
                textAlign: TextAlign.center,
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
    );
  }
}
