import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/button_model.dart';

class StudentDetails extends StatelessWidget {
  final student;

  const StudentDetails({super.key, required this.student});

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.06),
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
                  child: const Text("سعد"),
                ),
                SizedBox(
                  height: height * 0.03,
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
                  child: const Text("عبدالله"),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const Text("الصف"),
                ),
                Container(
                  padding: EdgeInsets.all(13),
                  width: width,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black)),
                  child: const Text("الثاني"),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const Text("فصيلة الدم "),
                ),
                Container(
                  padding: EdgeInsets.all(13),
                  width: width,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black)),
                  child: const Text("O+"),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const Text("رقم ولي الامر"),
                ),
                Container(
                  padding: EdgeInsets.all(13),
                  width: width,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black)),
                  child: const Text("0547897895"),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Center(child: ButtonModel(content: "موقع المنزل"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
