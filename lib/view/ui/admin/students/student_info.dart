import 'package:ameen/model/student.dart';
import 'package:ameen/utils/DatabaseHelper.dart';

// import 'package:ameen/view/ui/driver/student/student_list.dart';
import 'package:ameen/view/ui/widget/cusom_dialog.dart';
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
                    child: Text("الصف"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Text("${student.grade}"),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("فصيلة الدم"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Text(student.blood),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("رقم ولي الامر"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Text(student.phone),
                  ),
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
                                  dbHelper.deleteById(student.parentId, "parents");
                                  Get.off(() => const StudentsList());
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
                                onClose: () {
                                  Get.back();
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
