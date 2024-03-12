import 'dart:ffi';

import 'package:ameen/controller/admin_controller.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/widget/cusom_dialog.dart';
import 'package:ameen/view/ui/widget/custem_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../widget/button_model.dart';

AdminController controller = Get.find();

class WaitingStudent extends StatelessWidget {
  final student;

  const WaitingStudent({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          foregroundColor: Colors.white,
          title: const Text("معلومات الطالب"),
          centerTitle: true,
        ),
        body: SizedBox(
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.035),
                    child: Container(
                      margin: EdgeInsets.only(right: width * 0.27),
                      height: height * 0.15,
                      width: width * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          border: Border.all(
                              color: const Color.fromARGB(255, 113, 65, 146))),
                      child: Image(
                        width: width * 0.27,
                        image: AssetImage(student['img']),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("الاسم الاول"),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: const Text("هند"),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("الاسم الاخير"),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: const Text("محمد"),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("رقم الأحوال"),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: const Text("111679356"),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("رقم التواصل"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: const Text("0547897895"),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("موقع المنزل "),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: const Text(
                      "https://maps.app.goo.gl/ZvmTDH31evSNsS6i8?g_st=ic",
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  ButtonModel(
                    onTap: () {
                      Get.dialog(Dialog(
                        child: Container(
                          height: height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("اختيار الباص المناسب"),
                              Obx(
                                () => GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: height * 0.06,
                                    width: width * 0.6,
                                    decoration: BoxDecoration(
                                        color: PRIMARY_COLOR,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: CustomDropdownButton2(
                                        selectedItemColor: Colors.white,
                                        dropdownDecoration: BoxDecoration(
                                          color: PRIMARY_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        hintColor: Colors.white,
                                        borderColor:
                                            Colors.white.withOpacity(0),
                                        iconEnabledColor: Colors.white,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: width * 0.05,
                                        ),
                                        buttonHeight: height * 0.1,
                                        // buttonWidth: width * 0.5,
                                        // dropdownWidth: 20,
                                        hint: 'الباصات',
                                        value:
                                            controller.selectedBus.value.isEmpty
                                                ? null
                                                : controller.selectedBus.value,
                                        dropdownItems: controller.buses,
                                        onChanged: (val) {
                                          controller.selectedBus.value = val!;
                                        }),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
                    },
                    hMargin: width * 0.03,
                    height: height * 0.06,
                    backColor: PRIMARY_COLOR,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.045,
                    ),
                    content: "قبول",
                    textAlign: TextAlign.center,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                  ),
                  ButtonModel(
                    hMargin: width * 0.03,
                    backColor: PRIMARY_COLOR,
                    vMargin: height * 0.01,
                    height: height * 0.06,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.045,
                    ),
                    content: "رفض",
                    textAlign: TextAlign.center,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
