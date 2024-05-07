import 'package:Amin/controller/admin_controller.dart';
import 'package:Amin/controller/sign_controller.dart';
import 'package:Amin/model/driver.dart';
import 'package:Amin/model/student.dart';
import 'package:Amin/utils/DatabaseHelper.dart';
import 'package:Amin/utils/constants.dart';
import 'package:Amin/view/ui/admin/home.dart';
import 'package:Amin/view/ui/admin/students/waiting_list.dart';
import 'package:Amin/view/ui/widget/custom_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../widget/button_model.dart';

DatabaseHelper dbHelper = DatabaseHelper();

class WaitingStudent extends StatelessWidget {
  final StudentModel student;

  const WaitingStudent({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());

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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("الاسم الاول"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("الاسم الاخير"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("رقم الأحوال"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("رقم التواصل"),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("موقع المنزل "),
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
                      Get.dialog(SizedBox(
                          height: height * 0.3,
                          child: DialogWidget(student: student)));
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
                      Get.dialog(CustomDialog(
                        buttonOnTap: () {
                          dbHelper.deleteById(student.id, 'students');
                          dbHelper.deleteById(student.parentId, 'parents');
                          Get.off(() => const WaitingList());
                          deleteAccount();
                        },
                        buttonText: "نعم",
                        content: "هل انت متاكد من رفض الطالب؟",
                      ));
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

class DialogWidget extends StatelessWidget {
  final StudentModel student;

  const DialogWidget({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    AdminController controller = Get.find();

    Offset offset;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
        child: SizedBox(
      height: height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("اختيار الباص المناسب"),
          ),
          GestureDetector(
            onPanStart: (details) {
              offset = details.globalPosition;
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(offset.dx, offset.dy,
                    width - offset.dx, height - offset.dy),
                items: [
                  PopupMenuItem(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      width: double.maxFinite,
                      height: height * 0.3,
                      child: FutureBuilder<List<DriverModel>>(
                          future: dbHelper.getAllBuses(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: height * 0.3,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Text("${snapshot.error}"),);
                            } else if (snapshot.data == []) {
                              return Center(
                                child: Text("NO student found",
                                    style: TextStyle(fontSize: width * 0.05)),
                              );
                            }

                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                DriverModel driver = snapshot.data![i];
                                return IntrinsicHeight(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.selectedBus.value =
                                          driver.busId;

                                      Navigator.pop(context);
                                    },
                                    child: ButtonModel(
                                      vMargin: height * 0.005,
                                      height: height * 0.06,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      backColor: PRIMARY_COLOR,
                                      content: driver.busId,
                                      rowMainAxisAlignment:
                                          MainAxisAlignment.center,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    ),
                  ),
                ],
              );
            },
            child: Obx(() => Container(
                    height: height * 0.06,
                    width: width * 0.6,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: width * 0.05,
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        Text(
                          controller.selectedBus.value.isEmpty
                              ? "الباصات"
                              : controller.selectedBus.value,
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.04),
                        ),
                      ],
                    ))

                // child: CustomDropdownButton2(
                //     selectedItemColor: Colors.white,
                //     dropdownDecoration: BoxDecoration(
                //       color: PRIMARY_COLOR,
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     hintColor: Colors.white,
                //     borderColor: Colors.white.withOpacity(0),
                //     iconEnabledColor: Colors.white,
                //     icon: Icon(
                //       Icons.keyboard_arrow_down,
                //       size: width * 0.05,
                //     ),
                //     buttonHeight: height * 0.1,
                //     // buttonWidth: width * 0.5,
                //     // dropdownWidth: 20,
                //     hint: 'الباصات',
                //     value: controller.selectedBus.value.isEmpty
                //         ? null
                //         : controller.selectedBus.value,
                //     dropdownItems: controller.buses,
                //     onChanged: (val) {
                //       controller.selectedBus.value = val!;
                //     }),
                ),
          ),
          GestureDetector(
            onTap: () async {
              dbHelper.updateField(
                  'parents', student.parentId, "isEnabled", true);
              dbHelper.updateField('students', student.id, "busId",
                  controller.selectedBus.value);
              if (controller.selectedBus.value.isEmpty) {
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
                    title: "خطأ",
                    message: "الرحاء اختيار رقم الباص",
                    duration: const Duration(seconds: 2),
                    animationDuration: const Duration(milliseconds: 800),
                  ),
                );
              } else {
                Get.dialog(const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ));
                await Future.delayed(const Duration(seconds: 1));
                Get.offAll(() => const AdminHome());
                Get.showSnackbar(
                  GetSnackBar(
                    borderRadius: 20,
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.045, vertical: height * 0.015),
                    icon: Icon(
                      IconlyLight.user,
                      color: Colors.white,
                      size: width * 0.065,
                    ),
                    message: "تم قبول الطالب بنجاح",
                    duration: const Duration(seconds: 2),
                    animationDuration: const Duration(seconds: 1),
                  ),
                );
              }
            },
            child: Container(
                margin: const EdgeInsets.all(10),
                height: height * 0.06,
                width: width * 0.6,
                decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                    child: Text(
                  "موافق",
                  style: TextStyle(color: Colors.white),
                ))),
          ),
        ],
      ),
    ));
  }
}

void deleteAccount() async {
  SignController signController = Get.find();
  UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
          email: signController.parentEmail.text,
          password: signController.parenPassword.text);
  final user = FirebaseAuth.instance.currentUser;
  user!.delete();
}
