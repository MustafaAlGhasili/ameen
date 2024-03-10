import 'package:flutter/material.dart';
import '../../widget/button_model.dart';
import '../../widget/text_field.dart';
import 'sign_up.dart';


class School extends StatelessWidget {
  const School({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    controller.addSchoolsToMenu();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.045, vertical: height * 0.03),
        child: Column(
          children: [
            Text("معلومات المدرسة", style: TextStyle(fontSize: width * 0.07)),
            Container(
              padding: EdgeInsets.only(right: 6, top: height * 0.02),
              width: width,
              child: Text(
                "اختر مدرستك",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: width * 0.045),
              ),
            ),
            SizedBox(
              width: width * 0.9,
              height: height * 0.07,
              child: FittedBox(
                fit: BoxFit.fill,
                child:
                DropdownMenu(
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  menuStyle: const MenuStyle(),
                  width: width * 0.9,
                  dropdownMenuEntries: controller.schools.keys.map((school) {
                    return DropdownMenuEntry(
                      label: school,
                      value: controller.schools[school],
                    );
                  }).toList(),
                  onSelected: (value) {
                    controller.schoolValue.value = value!;
                    print(
                        'Selected: $value'); // Replace with your actual action
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 6, top: height * 0.02),
              width: width,
              child: Text(
                "اختر صفك",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: width * 0.045),
              ),
            ),
            SizedBox(
              width: width * 0.9,
              height: height * 0.07,
              child: FittedBox(
                fit: BoxFit.fill,
                child: DropdownMenu(
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  menuStyle: const MenuStyle(),
                  width: width * 0.9,
                  dropdownMenuEntries: controller.grades.keys.map((grade) {
                    return DropdownMenuEntry(
                      label: grade,
                      value: controller.grades[grade],
                    );
                  }).toList(),
                  onSelected: (value) {
                    controller.gradeValue.value = value!;
                    print(
                        'Selected: $value'); // Replace with your actual action
                  },
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            ButtonModel(
              onTap: () {
                controller.getLocation(context);
              },
              icon: Icons.map,
              width: width * 0.9,
              height: height * 0.06,
              content: 'اختر الموقع على الخريطة',
              rowMainAxisAlignment: MainAxisAlignment.center,
              textAlign: TextAlign.center,
              backColor: const Color.fromARGB(255, 113, 65, 146),
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.05,
              ),
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
                controller.step.value++;
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
    );
  }
}