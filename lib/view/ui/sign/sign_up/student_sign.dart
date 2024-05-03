import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../../controller/sign_controller.dart';
import '../../../../utils/validation.dart';
import '../../widget/button_model.dart';
import '../../widget/custem_dropdown_menu.dart';
import 'sign_up.dart';
import '../../widget/text_field.dart';

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

class Student extends StatelessWidget {
  const Student({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Validation validation = Validation();

    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    SignController controller = Get.find();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.045, vertical: height * 0.02),
            child: Column(
              children: [
                Text("معلومات الطالب",
                    style: TextStyle(fontSize: width * 0.07)),
                TextFieldModel(
                  validator: (val) => validation.validator(val),
                  controller: controller.studentFName,
                  text: "الاسم الاول",
                  vPadding: height * 0.03,
                  obscureText: false,
                ),
                TextFieldModel(
                  controller: controller.studentLName,
                  validator: (val) => validation.validator(val),
                  text: "الاسم الأخير",
                  vPadding: height * 0.03,
                  obscureText: false,
                ),
                TextFieldModel(
                  keyboardType: TextInputType.number,
                  controller: controller.studentNationalId,
                  validator: (val) => validation.validator(val),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  text: "رقم الاحوال",
                  vPadding: height * 0.03,
                  obscureText: false,
                ),
                TextFieldModel(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: controller.studentPhone,
                  validator: (val) => validation.phoneValidator(val),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  text: "رقم الهاتف",
                  vPadding: height * 0.03,
                  obscureText: false,
                ),
                TextFieldModel(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.studentEmail,
                  validator: (val) => validation.emailValidator(val),
                  text: "البريد الالكتروني",
                  vPadding: height * 0.03,
                  obscureText: false,
                ),
                TextFieldModel(
                  onTap: () => _selectDate(context),
                  validator: (val) => validation.validator(val),
                  readOnly: true,
                  controller: controller.studentBDate,
                  sufIcon: Icon(
                    IconlyLight.calendar,
                    size: width * 0.055,
                  ),
                  keyboardType: TextInputType.datetime,
                  text: "تاريخ الميلاد",
                  vPadding: height * 0.03,
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
                              child: Obx(() =>
                                  CustomDropdownButton2(

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
                              child: Obx(() =>
                                  CustomDropdownButton2(
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
                // SizedBox(
                //   height: height * 0.025,
                // ),
                ButtonModel(
                  vMargin: height * 0.02,
                  onTap: () {
                    print("Clicked");

                    if (formKey.currentState!.validate()) {
                      if (controller.bloodValue.value == '') {
                        snack(context, "الرجاء ادخال فصيله الدم");
                      } else if (controller.genderValue.value == '') {
                        snack(context, "الرجاء ادخال الجنس");
                      }
                      else {
                        controller.step.value++;
                      }
                    }
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
      ),
    );
  }
}

void snack(BuildContext context, String message){
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
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
      message: message,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 600),
    ),
  );
}
