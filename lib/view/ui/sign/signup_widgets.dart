import 'package:ameen/view/ui/home/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../controller/sign_controller.dart';
import '../widget/button_model.dart';
import '../widget/text_field.dart';

SignController controller = Get.find();


class Parent extends StatelessWidget {
  const Parent({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.04),
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
              height: height * 0.05,
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
      ),
    );
  }
}

class Student extends StatelessWidget {
  const Student({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SignController controller = Get.find();
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.03),
          child: Column(
            children: [
              Text("معلومات الطالب", style: TextStyle(fontSize: width * 0.07)),
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
                    onPressed: () {}, icon: const Icon(IconlyLight.calendar)),
                text: "تاريخ الميلاد",
                height: height * 0.06,
                obscureText: false,
              ),
              Obx(
                () => Padding(
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
                          items: controller.blood
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text("$e"),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            //controller.blood.value = value as RxList;
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.08,
              ),
              ButtonModel(
                onTap: () {
                  controller.step.value++;
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
            horizontal: width * 0.03, vertical: height * 0.04),
        child: Column(
          children: [
            Text("معلومات المدرسة", style: TextStyle(fontSize: width * 0.07)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              width: width,
              child: Text(
                "اختر مدرستك",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: width * 0.045),
              ),
            ),
            DropdownMenu(
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              width: width,
              child: Text(
                "اختر صفك",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: width * 0.045),
              ),
            ),
            DropdownMenu(
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
            TextFieldModel(
              text: "اكتب موقعك",
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
        content: 'التالي',
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
    // double height = MediaQuery.of(context).size.height;
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
                    controller.isAccepted.value =
                    !controller.isAccepted.value;
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
                      Text("اوافق على الشروط والاحكام", style: TextStyle(fontSize: width * 0.045)),
                    ],
                  ),
                ),
              ),
            ),
            ButtonModel(
              onTap: () {
                if (controller.isAccepted.value) {
                Get.to(const Home());
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
