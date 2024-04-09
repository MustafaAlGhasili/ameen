import 'package:ameen/controller/admin_controller.dart';
import 'package:ameen/model/student.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/admin/home.dart';
import 'package:ameen/view/ui/widget/custem_dropdown_menu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../widget/button_model.dart';

AdminController controller = Get.find();

class WaitingStudent extends StatelessWidget {
  final StudentModel student;

  const WaitingStudent({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper dbHelper = DatabaseHelper();
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
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1),
                    margin: EdgeInsets.only(top: height * 0.035),
                    decoration: const BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: width * 0.15,
                      child: CachedNetworkImage(
                        imageUrl: student.imgUrl ?? " ",
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Image(image: AssetImage("img/st1.png")),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
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
                    child: Text(student.fName),
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
                    child: Text(student.lName),
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
                    child: Text(student.nationalId),
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
                    child: Text(
                      student.address,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("اختيار الباص المناسب"),
                              ),
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
                              ),
                              GestureDetector(
                                onTap: () async{
                                  dbHelper.updateField('parents',
                                      student.parentId, "isEnabled", true);
                                  dbHelper.updateField('students', student.id,
                                      "busId", controller.selectedBus.value);
                                  if(controller.selectedBus.value.isEmpty){
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
                                        message: "الرحاء اختيار رقم الباص",
                                        duration: const Duration(seconds: 2),
                                        animationDuration:
                                        const Duration(milliseconds: 800),
                                      ),
                                    );
                                  }else{
                                    Get.dialog(const Center(
                                      child: CircularProgressIndicator(color: Colors.white,),
                                    ));
                                    await Future.delayed(const Duration(seconds: 1));
                                    Get.offAll(()=> const AdminHome());
                                    Get.showSnackbar(
                                      GetSnackBar(
                                        borderRadius: 20,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: width * 0.045,
                                            vertical: height * 0.015),
                                        icon: Icon(
                                          IconlyLight.user,
                                          color: Colors.white,
                                          size: width * 0.065,
                                        ),
                                        message: "تم قبول الطالب بنجاح",
                                        duration: const Duration(seconds: 2),
                                        animationDuration:
                                        const Duration(seconds: 1),
                                      ),
                                    );
                                  }

                                },
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    height: height * 0.06,
                                    width: width * 0.6,
                                    decoration: BoxDecoration(
                                        color: PRIMARY_COLOR,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: Text(
                                      "موافق",
                                      style: TextStyle(color: Colors.white),
                                    ))),
                              ),
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
                    onTap: () {
                      dbHelper.deleteById(student.id, 'students');
                      dbHelper.deleteById(student.parentId, 'parents');

                      Get.back();
                    },
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
