import 'package:ameen/controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../model/student.dart';
import '../../../../services/LocalStorageService.dart';
import '../../sign/start.dart';
import '../../widget/button_model.dart';
import '../../widget/cusom_dialog.dart';
import '../info.dart';
import '../settings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    HomeController controller = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.05),
          child: FutureBuilder<StudentModel?>(
            future: LocalStorageService.getStudent(),
            builder:
                (BuildContext context, AsyncSnapshot<StudentModel?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  print(snapshot.data);
                  final student = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "الملف الشخصي",
                        style: TextStyle(
                          fontSize: width * 0.07,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      CircleAvatar(
                        radius: width * 0.18,
                        backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: student.imgUrl ?? '',
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
                      Text(
                        "${student.fName} ${student.lName}",
                        style: TextStyle(
                          fontSize: width * 0.06,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      ButtonModel(
                        padding: width * 0.03,
                        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                        width: width * 0.9,
                        height: height * 0.07,
                        onTap: () {
                          Get.to(() => About());
                        },
                        backColor: const Color.fromARGB(255, 113, 65, 146),
                        content: "حسابي",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.05),
                        icon: IconlyLight.profile,
                        iconSize: width * 0.06,
                        vMargin: height * 0.01,
                      ),
                      ButtonModel(
                        padding: width * 0.03,
                        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                        width: width * 0.9,
                        height: height * 0.07,
                        onTap: () {
                          Get.dialog(
                            CustomDialog(
                                buttonOnTap: () async {
                                  // absent notification

                                  Get.dialog(
                                    const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );

                                  await controller.createAbsenceRequest();
                                  //TODO
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
                                      message: "تم ارسال اشعار الغياب بنجاح",
                                      duration: const Duration(seconds: 2),
                                      animationDuration:
                                          const Duration(milliseconds: 600),
                                    ),
                                  );
                                  Get.back(closeOverlays: true);
                                },
                                buttonText: "نعم",
                                content: "هل انت متاكد من اشعار الغياب؟"),
                          );
                        },
                        backColor: const Color.fromARGB(255, 113, 65, 146),
                        content: "اشعار غياب",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.05),
                        icon: Icons.inbox_outlined,
                        iconSize: width * 0.06,
                        vMargin: height * 0.01,
                      ),
                      ButtonModel(
                        padding: width * 0.03,
                        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                        width: width * 0.9,
                        height: height * 0.07,
                        onTap: () {
                          Get.to(() => const Settings());
                        },
                        backColor: const Color.fromARGB(255, 113, 65, 146),
                        content: "الإعدادات",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.05),
                        icon: IconlyLight.setting,
                        iconSize: width * 0.06,
                        vMargin: height * 0.01,
                      ),
                      ButtonModel(
                        rowMainAxisAlignment: MainAxisAlignment.center,
                        width: width * 0.9,
                        height: height * 0.07,
                        onTap: () async {
                          Get.dialog(CustomDialog(
                            buttonText: "حسنا",
                            content: "هل تريد تسجيل الخروج؟",
                            buttonOnTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Get.offAll(() => const Start());
                            },
                          ));
                        },
                        backColor: Colors.red,
                        content: "تسجيل خروج",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: width * 0.05),
                        vMargin: height * 0.04,
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
