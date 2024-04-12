import 'package:ameen/controller/sign_controller.dart';
import 'package:ameen/model/parent.dart';
import 'package:ameen/model/student.dart';
import 'package:ameen/services/LocalStorageService.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/home/home.dart';

// import 'package:ameen/view/ui/home/info.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../utils/validation.dart';
import '../widget/custem_dropdown_menu.dart';
import '../widget/text_field.dart';
import 'info.dart';

Validation validation = Validation();

class Edit extends StatelessWidget {
  final no;
  StudentModel? student;
  ParentModel? parent;

  Edit({super.key, required this.no, this.parent, this.student});

  @override
  Widget build(BuildContext context) {
    String name = no == 0 ? "الطالب" : "ولي الامر";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text("تعديل بيانات $name"),
          ),
          backgroundColor: Colors.white,
          body: no == 0 ? Student(student: student!) : Parent(parent: parent!)),
    );
  }
}

class Parent extends StatelessWidget {
  final ParentModel parent;

  const Parent({super.key, required this.parent});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    TextEditingController fName = TextEditingController();
    TextEditingController lName = TextEditingController();
    TextEditingController nationalId = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();

    fName.text = parent.fName;
    lName.text = parent.lName;
    nationalId.text = parent.nationalId;
    phone.text = parent.phone;
    email.text = parent.email;

    DatabaseHelper dbHelper = DatabaseHelper();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.07,
            ),
            TextFieldModel(
              onChanged: (val) {
                parent.fName = val;
              },
              hPadding: width * 0.04,
              validator: (val) => validation.validator(val),
              controller: fName,
              keyboardType: TextInputType.name,
              text: "الاسم الاول",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              onChanged: (val) {
                parent.lName = val;
              },
              hPadding: width * 0.04,
              validator: (val) => validation.validator(val),
              controller: lName,
              keyboardType: TextInputType.name,
              text: "الاسم الأخير",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              onChanged: (val) {
                parent.nationalId = val;
              },
              hPadding: width * 0.04,
              validator: (val) => validation.validator(val),
              controller: nationalId,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              text: "رقم الاحوال",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              onChanged: (val) {
                parent.phone = val;
              },
              hPadding: width * 0.04,

              validator: (val) => validation.phoneValidator(val),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 10,
              controller: phone,
              // vPadding: height * 0.035,
              keyboardType: TextInputType.number,
              text: "رقم التواصل",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              onChanged: (val) {
                parent.email = val;
              },
              hPadding: width * 0.04,

              validator: (val) => validation.emailValidator(val),
              controller: email,
              // vPadding: height * 0.035,
              keyboardType: TextInputType.emailAddress,
              text: "الإيميل",
            ),
            SizedBox(
              height: height * 0.05,
            ),
            ButtonModel(
              content: 'حفظ',
              height: height * 0.05,
              width: width * 0.9,
              rowMainAxisAlignment: MainAxisAlignment.center,
              backColor: PRIMARY_COLOR,
              style: TextStyle(color: Colors.white, fontSize: width * 0.05),
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  Get.dialog(
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );

                  await LocalStorageService.saveParent(parent);

                  await dbHelper.update(parent, 'parents');

                  Get.off(() => Home(
                        index: 2,
                      ));
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
                      message: "تم تحديث البيانات بنجاح",
                      duration: const Duration(seconds: 2),
                      animationDuration: const Duration(milliseconds: 800),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Student extends StatelessWidget {
  final StudentModel student;

  const Student({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    SignController controller = SignController();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    TextEditingController fName = TextEditingController();
    TextEditingController lName = TextEditingController();
    TextEditingController nationalId = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();

    fName.text = student.fName;
    lName.text = student.lName;
    nationalId.text = student.nationalId;
    phone.text = student.phone;
    email.text = student.email;

    DatabaseHelper dbHelper = DatabaseHelper();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.07,
            ),
            TextFieldModel(
              onChanged: (val) {
                student.fName = val;
              },
              hPadding: width * 0.04,
              validator: (val) => validation.validator(val),
              controller: fName,
              keyboardType: TextInputType.name,
              text: "الاسم الاول",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              onChanged: (val) {
                student.lName = val;
              },
              hPadding: width * 0.04,
              validator: (val) => validation.validator(val),
              controller: lName,
              keyboardType: TextInputType.name,
              text: "الاسم الأخير",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              onChanged: (val) {
                student.nationalId = val;
              },
              hPadding: width * 0.04,
              validator: (val) => validation.validator(val),
              controller: nationalId,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              text: "رقم الاحوال",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              hPadding: width * 0.04,
              onChanged: (val) {
                student.phone = val;
              },
              validator: (val) => validation.phoneValidator(val),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 10,
              controller: phone,
              // vPadding: height * 0.035,
              keyboardType: TextInputType.number,
              text: "رقم التواصل",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              hPadding: width * 0.04,

              onChanged: (val) {
                student.email = val;
              },
              validator: (val) => validation.emailValidator(val),
              controller: email,
              // vPadding: height * 0.035,
              keyboardType: TextInputType.emailAddress,
              text: "الإيميل",
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.02, horizontal: width * 0.04),
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
                                  ? student.blood
                                  : controller.bloodValue.value,
                              dropdownItems: controller.blood,
                              onChanged: (val) {
                                student.blood = val!;
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
                                    ? student.gender
                                    : controller.genderValue.value,
                                dropdownItems: controller.genders,
                                onChanged: (val) {
                                  student.gender = val!;
                                },
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ButtonModel(
              content: 'حفظ',
              height: height * 0.05,
              width: width * 0.9,
              rowMainAxisAlignment: MainAxisAlignment.center,
              backColor: PRIMARY_COLOR,
              style: TextStyle(color: Colors.white, fontSize: width * 0.05),
              onTap: () async {
                try {
                  if (formKey.currentState!.validate()) {
                    Get.dialog(
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                    await LocalStorageService.saveStudent(student);

                    await dbHelper.update(student, 'students');

                    Get.offAll(() => Home(
                          index: 2,
                        ));
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
                        message: "تم تحديث البيانات بنجاح",
                        duration: const Duration(seconds: 2),
                        animationDuration: const Duration(milliseconds: 800),
                      ),
                    );
                  }
                } catch (e) {
                  print("Error $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
