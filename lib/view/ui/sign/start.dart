import 'package:ameen/view/ui/sign/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/LocalStorageService.dart';

List data = [
  ["ولي الامر", 'img/parent.png', '1'],
  ["السائق", 'img/driver.png', '2'],
  ["المشرف", 'img/instractor.png', '3']
];

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    super.initState();
    LocalStorageService.clearAllData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: ,
        body: Container(
          padding: EdgeInsets.all(height * 0.03),
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.17),
              Text("أمين",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.07,
                  )),
              SizedBox(height: height * 0.025),
              Text("شريك طفلك بالرحلة المدرسية",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.029,
                  )),
              SizedBox(
                height: height * 0.5,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () {
                            Get.to(() => SignIn(loginType: i));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.1),
                                child: Text("${data[i][0]}",
                                    style: TextStyle(
                                      fontSize: height * 0.04,
                                      color: Colors.black87,
                                    )),
                              ),
                              Image(
                                height: height * 0.1,
                                image: AssetImage("${data[i][1]}"),
                              ),
                            ],
                          )),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
