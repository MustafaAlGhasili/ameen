import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/widget/cusom_dialog.dart';
import 'package:ameen/view/ui/widget/custem_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../widget/button_model.dart';

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
                  ButtonModel(
                    onTap: () {
                      Get.dialog(Dialog(
                        child: Container(
                          height: height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("اختيار الباص المناسب"),
                              GestureDetector(
                                onTap: (){

                                },
                                child: Container(
                                  height: height * 0.06,
                                  width: width * 0.6,
                                  decoration: BoxDecoration(
                                      color: PRIMARY_COLOR,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                      child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: width * 0.19),
                                        child: const Text(
                                          "الباصات",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  )),
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
