import 'package:ameen/model/student.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:ameen/view/ui/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StudentMap extends StatelessWidget {
  final StudentModel model;

  const StudentMap({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    LatLng point1 = LatLng(model.latitude!, model.longitude!);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "الخريطة",
            style: TextStyle(fontSize: width * 0.065),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: point1,
                zoom: 15.0,
              ),
              myLocationEnabled: true,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                height: height * 0.4,
                width: width,
                padding: EdgeInsets.all(width * 0.05),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: width * 0.08,
                              child: const Image(
                                image: AssetImage('img/img.png'),
                              ),
                            ),
                            SizedBox(width: width * 0.04),
                            Text(
                              "${model.fName} ${model.lName}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: width * 0.05),
                            ),
                          ],
                        ),
                        Text(
                          "${model.latitude}",
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.045),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      height: height * 0.17,
                      width: width,
                      padding: EdgeInsets.only(right: width * 0.04),
                      child: Text(
                        "حي الملقا \nشارع الخير \nرقم المنزل 1",
                        style: TextStyle(fontSize: width * 0.06),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    ButtonModel(
                      onTap: () => problemDialog(context),
                      height: height * 0.07,
                      content: 'تواجه مشكلة ؟',
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      backColor: Colors.red,
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.05),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void problemDialog(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  Get.dialog(Dialog(
    backgroundColor: Colors.white,
    child: SizedBox(
      height: height * 0.3,
      child: Column(
        children: [
          SizedBox(
            height: height * 0.015,
          ),
          Text(
            "تواجهة مشكلة ؟",
            style: TextStyle(fontSize: width * 0.05),
          ),
          SizedBox(height: height * 0.01),
          ButtonModel(
            hMargin: width * 0.04,
            height: height * 0.06,
            content: 'الطالب لم ياتي',
            rowMainAxisAlignment: MainAxisAlignment.center,
            backColor: PRIMARY_COLOR,
            style: TextStyle(color: Colors.white, fontSize: width * 0.05),
          ),
          ButtonModel(
            hMargin: width * 0.04,
            vMargin: height * 0.015,
            height: height * 0.06,
            content: 'تسجيل الحضور يدويا',
            rowMainAxisAlignment: MainAxisAlignment.center,
            backColor: PRIMARY_COLOR,
            style: TextStyle(color: Colors.white, fontSize: width * 0.05),
          ),
          ButtonModel(
            onTap: () {
              navigator?.pop();
              Get.dialog(
                const CustomDialog(
                  buttonText: '050XXXXXX',
                  content: 'رقم المشرف',
                ),
              );
            },
            hMargin: width * 0.04,
            height: height * 0.06,
            content: 'الاتصال بالمشرف',
            rowMainAxisAlignment: MainAxisAlignment.center,
            backColor: PRIMARY_COLOR,
            style: TextStyle(color: Colors.white, fontSize: width * 0.05),
          )
        ],
      ),
    ),
  ));
}
