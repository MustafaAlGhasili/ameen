import 'package:ameen/controller/sign_controller.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:ameen/view/ui/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../sign/sign_up.dart';
import '../widget/custem_dropdown_menu.dart';
import 'home.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SignController controller = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          title: Text("المعلومات الشخصية",
              style: TextStyle(fontSize: width * 0.06)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.03),
            child: Column(
              children: [
                Text("معلومات الطالب",
                    style: TextStyle(fontSize: width * 0.07)),
                const SizedBox(
                  height: 20,
                ),
                TextFieldModel(
                  isEnabled: false,

                  controller: controller.studentFName,
                  text: "الاسم الاول",
                  vPadding: height * 0.035,
                  obscureText: false,
                ),
                TextFieldModel(
                  isEnabled: false,

                  controller: controller.studentLName,
                  text: "الاسم الأخير",
                  vPadding: height * 0.035,
                  obscureText: false,
                ),
                TextFieldModel(
                  isEnabled: false,
                  keyboardType: TextInputType.number,
                  controller: controller.studentNationalId,
                  text: "رقم الاحوال",
                  vPadding: height * 0.035,
                  obscureText: false,
                ),
                TextFieldModel(
                  isEnabled: false,
                  style: const TextStyle(color: Colors.black),
                  controller: controller.studentBDate,
                  sufIcon: IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(
                        IconlyLight.calendar,
                        size: width * 0.055,
                      )),
                  keyboardType: TextInputType.datetime,
                  text: "تاريخ الميلاد",
                  vPadding: height * 0.035,
                  obscureText: false,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: width * 0.035),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              "فصيلة الدم",
                              style: TextStyle(fontSize: height * 0.021),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.055,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Obx(() => CustomDropdownButton2(
                                  // dropdownWidth: 20,
                                  hint: '',
                                  value: controller.bloodValue.value.isEmpty
                                      ? null
                                      : controller.bloodValue.value,
                                  dropdownItems: controller.blood,
                                  onChanged: (val) {
                                    controller.bloodValue.value = val!;
                                  })),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              "الجنس",
                              style: TextStyle(fontSize: height * 0.021),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.055,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Obx(() => CustomDropdownButton2(
                                    hint: '',
                                    value: controller.genderValue.value.isEmpty
                                        ? null
                                        : controller.genderValue.value,
                                    dropdownItems: controller.genders,
                                    onChanged: (val) {
                                      controller.genderValue.value = val!;
                                    },
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _selectDate(BuildContext context) async {
  final selected = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1980, 1, 1),
    lastDate: DateTime.now(),
  );
  if (selected != null && selected != DateTime.now()) {
    // controller.selectedDate = selected;
    controller.studentBDate.text =
        "${selected.year}-${selected.month}-${selected.day}";
    print(controller.studentBDate.text);
  }
}
