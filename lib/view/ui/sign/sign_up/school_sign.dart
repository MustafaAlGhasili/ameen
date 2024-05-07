import 'package:Amin/controller/sign_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../../controller/camera_controller.dart';
import '../../widget/button_model.dart';
import '../../widget/text_field.dart';
import 'sign_up.dart';

class School extends StatelessWidget {
  const School({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    controller.addSchoolsToMenu();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.045, vertical: height * 0.03),
          child: Column(
            children: [
              Text("معلومات المدرسة", style: TextStyle(fontSize: width * 0.07)),
              SizedBox(
                height: height * 0.03,
              ),
              DropdownButtonFormField(
                hint: const Text("اختر مدرستك"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                borderRadius: BorderRadius.circular(5),
                items: controller.schools.keys.map((school) {
                  return DropdownMenuItem(
                    alignment: Alignment.centerRight,
                    value: controller.schools[school],
                    child: Text(school),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.schoolValue.value = value!;
                },
                validator: (val) => validator(val),

              ),
              SizedBox(
                height: height * 0.05,
              ),
              DropdownButtonFormField(
                hint: const Text("اختر صفك"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                borderRadius: BorderRadius.circular(5),
                items: controller.grades.keys.map((grade) {
                  return DropdownMenuItem(
                    alignment: Alignment.centerRight,
                    value: controller.grades[grade],
                    child: Text(grade, style: const TextStyle(height: 0.5)),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.gradeValue.value = value!;
                },
                validator: (val) => validator(val),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GetBuilder<SignController>(
                builder: (controller) {
                  controller.update();
                  if (controller.mapSelected) {
                    return ButtonModel(
                      onTap: () {
                        controller.getLocation(context);
                      },
                      icon: Icons.map,
                      width: width * 0.9,
                      height: height * 0.07,
                      content: 'تعديل الموقع على الخريطة',
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      textAlign: TextAlign.center,
                      backColor: Colors.green,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                      ),
                    );
                  } else {
                    return ButtonModel(
                      onTap: () {

                        controller.getLocation(context);

                      },
                      icon: Icons.map,
                      width: width * 0.9,
                      height: height * 0.07,
                      content: 'اختر الموقع على الخريطة',
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      textAlign: TextAlign.center,
                      backColor: const Color.fromARGB(255, 113, 65, 146),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                      ),
                    );
                  }
                },
              ),
              TextFieldModel(
                controller: controller.address,
                style: TextStyle(height: height * 0.0027),
                text: "اكتب وصف موقعك",
                vPadding: height * 0.035,
              ),
              SizedBox(
                height: height * 0.09,
              ),
              ButtonModel(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    if (controller.isLocationPicked == true) {
                      Get.put(CamController());
                      controller.step.value++;
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
                          message: "الرجاء ادخال الموقع",
                          duration: const Duration(seconds: 2),
                          animationDuration: const Duration(milliseconds: 600),
                        ),
                      );
                    }
                  }
                  // Get.to(() => const StudentInfo());
                },
                width: width * 0.9,
                height: height * 0.06,
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

String? validator(int? value) {
  if (value == null) {
    return '*required';
  }
  return null;
}
//
// String? validateDropdown() {
//   if (controller.schoolValue == || _selectedValue!.isEmpty) {
//     return 'Please select an item from the dropdown.';
//   }
//   return null; // Return null if validation passes
// }
