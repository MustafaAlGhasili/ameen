import 'package:Amin/model/parent.dart';
import 'package:Amin/model/student.dart';
import 'package:Amin/utils/DatabaseHelper.dart';
import 'package:Amin/view/ui/admin/home.dart';
import 'package:Amin/view/ui/widget/custom_dialog.dart';
import 'package:Amin/view/ui/widget/custom_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';
import 'students_list.dart';
import '../../widget/button_model.dart';

class StudentDetails extends StatelessWidget {
  final StudentModel student;
  final int no;

  const StudentDetails({
    super.key,
    required this.student,
    required this.no,
  });

  @override
  Widget build(BuildContext context) {
    ParentModel? parent;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    DatabaseHelper dbHelper = DatabaseHelper();
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
                      radius: width * 0.2,
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
                  CustomContainer(text: student.fName),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("الاسم الاخير"),
                  ),
                  CustomContainer(text: student.lName),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("الصف"),
                  ),
                  CustomContainer(text: "${student.grade}"),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("فصيلة الدم"),
                  ),
                  CustomContainer(text: student.blood),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("رقم ولي الامر"),
                  ),
                  FutureBuilder<ParentModel?>(
                      future: dbHelper.getParentById(student.parentId),
                      builder: (context, snapshot) {
                        parent = snapshot.data;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          return CustomContainer(text: parent!.phone);
                        }
                        return const SizedBox();
                      }),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  ButtonModel(
                    onTap: () =>
                        _launchMap(student.latitude!, student.longitude!),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: width * 0.045,
                    ),
                    content: "موقع المنزل",
                    textAlign: TextAlign.center,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                  ),
                  no == 0
                      ? ButtonModel(
                          onTap: () {
                            Get.dialog(CustomDialog(
                                buttonOnTap: () {
                                  dbHelper.deleteById(student.id, "students");
                                  dbHelper.deleteById(
                                      student.parentId, "parents");
                                  Get.offAll(const AdminHome());
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
                                      message: "تم ازاله الطالب بنجاح",
                                      duration: const Duration(seconds: 2),
                                      animationDuration:
                                          const Duration(milliseconds: 600),
                                    ),
                                  );
                                },
                                buttonText: "نعم",
                                content: "هل متأكد من ازاله الطالب؟"));
                          },
                          vMargin: height * 0.01,
                          height: height * 0.073,
                          backColor: Colors.red,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.045,
                          ),
                          content: "إزاله الطالب",
                          textAlign: TextAlign.center,
                          rowMainAxisAlignment: MainAxisAlignment.center,
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: height * 0.02,
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

Future<void> _launchMap(final double latitude, final double longitude) async {
  final encodedLat = Uri.encodeComponent(latitude.toString());
  final encodedLng = Uri.encodeComponent(longitude.toString());

  final url =
      'https://www.google.com/maps/search/?api=1&query=$encodedLat,$encodedLng&zoom=16';

  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch map with pin');
  }
}
