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
          title: Text("المعلومات الشخصية", style: TextStyle(fontSize: width * 0.06)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.03),
            child: Column(
              children: [
                Text("معلومات الطالب", style: TextStyle(fontSize: width * 0.07)),
                TextFieldModel(
                  text: "الاسم الاول",
                  vPadding: height * 0.06,
                  obscureText: false,
                ),
                TextFieldModel(
                  text: "الاسم الأخير",
                  vPadding: height * 0.06,
                  obscureText: false,
                ),
                TextFieldModel(
                  text: "رقم الاحوال",
                  vPadding: height * 0.06,
                  obscureText: false,
                ),
                TextFieldModel(
                  sufIcon: IconButton(
                      onPressed: () {}, icon: const Icon(IconlyLight.calendar)),
                  text: "تاريخ الميلاد",
                  vPadding: height * 0.06,
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
      ),
    );
  }
}
