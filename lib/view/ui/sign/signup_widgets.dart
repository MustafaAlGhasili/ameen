import 'package:ameen/view/ui/home/home.dart';
import 'package:ameen/view/ui/widget/custem_dropdown_menu.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../controller/sign_controller.dart';
import '../widget/button_model.dart';
import '../widget/text_field.dart';
// import 'package:cr_calendar/cr_calendar.dart';

SignController controller = Get.find();

class Parent extends StatelessWidget {
  const Parent({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
                controller: controller.parenPassword,
                // vPadding: height * 0.035,
                keyboardType: TextInputType.visiblePassword,
                text: "ادخل كلمة السر",
                obscureText: true,
              ),
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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SignController controller = Get.find();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.045, vertical: height * 0.03),
            child: Column(
              children: [
                Text("معلومات الطالب",
                    style: TextStyle(fontSize: width * 0.07)),
                TextFieldModel(
                  controller: controller.studentFName,
                  text: "الاسم الاول",
                  vPadding: height * 0.035,
                  obscureText: false,
                ),
                TextFieldModel(
                  controller: controller.studentLName,
                  text: "الاسم الأخير",
                  vPadding: height * 0.035,
                  obscureText: false,
                ),
                TextFieldModel(
                  controller: controller.studentNationalId,
                  text: "رقم الاحوال",
                  vPadding: height * 0.035,
                  obscureText: false,
                ),
                TextFieldModel(
                  controller: controller.studentBDate,
                  sufIcon: IconButton(
                      onPressed: () => _selectDate(context),
                      // {
                      //   final selectedDate = showCrDatePicker(
                      //     context,
                      //     properties: DatePickerProperties(
                      //       // firstWeekDay: WeekDay.saturday,
                      //       okButtonBuilder: (onPress) => ElevatedButton(
                      //           child: const Text('OK'),
                      //           onPressed: () {
                      //             // controller.studentBDate.text =
                      //             // ;
                      //           }),
                      //       cancelButtonBuilder: (onPress) => OutlinedButton(
                      //           child: const Text('CANCEL'),
                      //           onPressed: () {
                      //             Get.back(closeOverlays: true);
                      //           }),
                      //       initialPickerDate: DateTime.now(),

                      //       onDateRangeSelected:
                      //           (DateTime? rangeBegin, DateTime? rangeEnd) {},
                      //     ),
                      //   );
                      //   print(selectedDate);
                      // },
                      icon: Icon(
                        IconlyLight.calendar,
                        size: width * 0.055,
                      )),
                  isEnabled: false,
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
                            height: height * 0.065,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: DropdownMenu(
                                controller: controller.studentBlood,
                                dropdownMenuEntries: const [
                                  DropdownMenuEntry(
                                    value: "sckn",
                                    label: "Sckm",
                                  )
                                ],
                                menuStyle: const MenuStyle(
                                  shape: MaterialStatePropertyAll(
                                      ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)))),
                                ),
                              ),
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
                                child: Obx(()=>CustomDropdownButton2(
                                  // dropdownWidth: 20,
                                    hint: '',
                                    value: controller.bloodValue.value.isEmpty
                                        ? null
                                        : controller.bloodValue.value,
                                    dropdownItems: controller.blood,
                                    onChanged: (val) {
                                      controller.bloodValue.value = val!;
                                    })),
                                // DropdownMenu(

                                //   controller: controller.studentSex,
                                //   dropdownMenuEntries: const [
                                //     DropdownMenuEntry(
                                //       value: "M",
                                //       label: "M",
                                //     ),
                                //     DropdownMenuEntry(
                                //       value: "F",
                                //       label: "F",
                                //     ),
                                //   ],
                                //   menuStyle: const MenuStyle(
                                //     shape: MaterialStatePropertyAll(
                                //         ContinuousRectangleBorder(
                                //             borderRadius: BorderRadius.all(
                                //                 Radius.circular(30)))),
                                //   ),
                                // ),
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
                ButtonModel(
                  onTap: () {
                    print(!controller.studentSex.isBlank!);
                    print(!controller.studentBlood.isBlank!);

                    if (formKey.currentState!.validate() &&
                        controller.studentBlood == null &&
                        controller.studentSex.isBlank!) {
                      controller.step.value++;
                      controller.sendDataToDatabase();
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

class School extends StatelessWidget {
  const School({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              height: height * 0.075,
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
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(label: "snck", value: 2),
                      DropdownMenuEntry(label: "lnlkl", value: 2),
                      DropdownMenuEntry(label: "ibi", value: 2),
                    ]),
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
              height: height * 0.075,
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
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(label: "snck", value: 2),
                      DropdownMenuEntry(label: "lnlkl", value: 2),
                      DropdownMenuEntry(label: "ibi", value: 2),
                    ]),
              ),
            ),
            TextFieldModel(
              style: TextStyle(height: height * 0.0027),
              text: "اكتب موقعك",
              vPadding: height * 0.035,
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
//
// class FaceRecognition extends StatelessWidget {
//   const FaceRecognition({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     CamController cameraController  = Get.find();
//     return FutureBuilder(
//         future: cameraController.initializeControllerFuture(),
//         builder: (context, snapshot) {
//           if (!cameraController.cameraController.value.isInitialized) {
//             return const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ));
//           }
//           return Align(
//             alignment: Alignment.center,
//             child: Container(
//
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(1000),
//                   border: Border.all(width: 10, color: Colors.white)),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(1000),
//                 child: SizedBox(
//                   width: width * 0.9,
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: CameraPreview(
//                         cameraController.cameraController),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: ButtonModel(
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
    );
  }
}

class PrivacyTerms extends StatelessWidget {
  const PrivacyTerms({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      // physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          children: [
            Text("الشروط والأحكام", style: TextStyle(fontSize: width * 0.07)),
            SizedBox(
              height: width * 0.02,
            ),
            Text(
                style: TextStyle(fontSize: width * 0.04),
                "مرحبًا بك في تطبيق أمين "
                "يرجى قراءة هذه الشروط والأحكام بعناية قبل استخدام التطبيق. بمجرد استخدامك للتطبيق، فإنك توافق على هذه الشروط والأحكام بشكل كامل وملزم.\n"
                "1. ملكية المحتوى: "
                "المحتوى الذي يتم مشاركته أو نشره عبر تطبيق أمين هو ملكية التطبيق والمستخدمين والجهات الخارجية. لا يجوز نسخ أو نشر المحتوى دون إذن كتابي.\n"
                "2. تراخيص الاستخدام: "
                "يجب استخدام تطبيق أمين بأمان وبالامتثال لجميع القوانين واللوائح المحلية والدولية. يجب عدم استخدام التطبيق بأي طريقة تنتهك حقوق الملكية الفكرية أو تعرض سلامة المستخدمين للخطر.\n"
                "3. الخصوصية وحماية البيانات: "
                "نحن نلتزم بحماية خصوصية المستخدمين. سيتم جمع واستخدام البيانات الشخصية وفقًا لسياسة الخصوصية المتاحة في التطبيق.\n"
                "4. التعويض والضمان: "
                "يجب على المستخدمين فهم أن التطبيق يقدم كما هو ودون أي ضمانات صريحة أو ضمانات من أي نوع.\n"
                "5. إنهاء الخدمة: "
                "يمكن أن تؤدي انتهاكات الشروط والأحكام إلى إنهاء حظر المستخدمين. نحتفظ بالحق في إنهاء الخدمة في أي وقت.\n"
                "6. تحديث الشروط والأحكام: "
                "يمكن أن تتغير هذه الشروط والأحكام مع مرور الوقت. سيتم إشعار المستخدمين بأي تغييرات."),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.02, horizontal: width * 0.01),
                child: GestureDetector(
                  onTap: () {
                    controller.isAccepted.value = !controller.isAccepted.value;
                  },
                  child: Row(
                    children: [
                      Checkbox(
                          value: controller.isAccepted.value,
                          onChanged: (val) {
                            controller.isAccepted.value =
                                !controller.isAccepted.value;
                          }),
                      // SizedBox(
                      //   width: width * 0.01,
                      // ),
                      Text("اوافق على الشروط والاحكام",
                          style: TextStyle(fontSize: width * 0.045)),
                    ],
                  ),
                ),
              ),
            ),
            ButtonModel(
              onTap: () {
                if (controller.isAccepted.value) {
                  Get.offAll(() => const Home());
                  controller.sendDataToDatabase();
                } else {
                  Get.showSnackbar(
                    const GetSnackBar(
                      title: "Bad",
                      message: "Very Bad",
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
                // Get.to(() => const StudentInfo());
              },
              width: width * 0.9,
              content: 'التالي',
              height: height * 0.055,
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
