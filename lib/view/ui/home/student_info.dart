import 'package:ameen/controller/sign_controller.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:ameen/view/ui/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

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
                TextFieldModel(
                  text: "الاسم الاول",
                  vPadding: height * 0.04,
                  obscureText: false,
                ),
                TextFieldModel(
                  text: "الاسم الأخير",
                  vPadding: height * 0.04,
                  obscureText: false,
                ),
                TextFieldModel(
                  text: "رقم الاحوال",
                  vPadding: height * 0.04,
                  obscureText: false,
                ),
                TextFieldModel(
                  sufIcon: IconButton(
                      onPressed: () {}, icon: const Icon(IconlyLight.calendar)),
                  text: "تاريخ الميلاد",
                  vPadding: height * 0.04,
                  obscureText: false,
                ),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(top: height * 0.04),
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
                              child: const FittedBox(
                                fit: BoxFit.fill,
                                child: DropdownMenu(
                                  dropdownMenuEntries: [
                                    DropdownMenuEntry(
                                      value: "sckn",
                                      label: "Sckm",
                                    )
                                  ],
                                  menuStyle: MenuStyle(
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
                              height: height * 0.065,
                              child: const FittedBox(
                                fit: BoxFit.fill,
                                child: DropdownMenu(
                                  dropdownMenuEntries: [
                                    DropdownMenuEntry(
                                      value: "sckn",
                                      label: "Sckm",
                                    )
                                  ],
                                  menuStyle: MenuStyle(
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
                  height: height * 0.06,
                  content: '',
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
