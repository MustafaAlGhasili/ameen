import 'package:ameen/model/driver.dart';
import 'package:ameen/services/LocalStorageService.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/driver/student/student_list.dart';
import 'package:ameen/view/ui/driver/trip.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:ameen/view/ui/widget/cusom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

DatabaseHelper dbHelper = DatabaseHelper();

class DriverHome extends StatelessWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const DrawerModel(),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: PRIMARY_COLOR,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image(
                  image: AssetImage('img/logo.png'),
                  height: width * 0.6,
                ),
              ),
              Container(
                width: width,
                height: height * 0.62,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(width * 0.1)),
                ),
                child: FutureBuilder<DriverModel?>(
                  future: LocalStorageService.getDriver(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final DriverModel? driver = snapshot.data;

                        if (driver != null) {
                          return Column(
                            children: [
                              SizedBox(height: height * 0.08),
                              Text(
                                "اهلا بعودتك ${driver.fName} ${driver.lName}",
                                style: TextStyle(fontSize: width * 0.06),
                              ),
                              ButtonModel(
                                onTap: () {
                                  Get.dialog(
                                    SizedBox(
                                      child: Dialog(
                                        child: SizedBox(
                                          height: height * 0.25,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: height * 0.04,
                                              ),
                                              Text(
                                                "الرجاء اختيار",
                                                style: TextStyle(
                                                    fontSize: width * 0.045),
                                              ),
                                              ButtonModel(
                                                onTap: () {
                                                  Get.to(() => const Trip(
                                                        tripType: 1,
                                                      ));
                                                },
                                                content: 'رحلة الصباح',
                                                backColor: PRIMARY_COLOR,
                                                height: height * 0.05,
                                                hMargin: width * 0.05,
                                                rowMainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.04),
                                                vMargin: height * 0.015,
                                              ),
                                              ButtonModel(
                                                onTap: () {
                                                  Get.to(() => const Trip(
                                                        tripType: 2,
                                                      ));
                                                },
                                                content: 'رحلة المساء',
                                                backColor: PRIMARY_COLOR,
                                                height: height * 0.05,
                                                hMargin: width * 0.05,
                                                rowMainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.04),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                height: height * 0.07,
                                width: width,
                                rowMainAxisAlignment: MainAxisAlignment.center,
                                backColor: PRIMARY_COLOR,
                                vMargin: height * 0.1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.055,
                                ),
                                hMargin: width * 0.07,
                                content: 'ابدا العمل',
                              ),
                              ButtonModel(
                                onTap: () {
                                  Get.dialog(
                                    CustomDialog(
                                      buttonText: 'نعم',
                                      content: 'هل انت متاكد من تسجيل الخروج؟',
                                      buttonOnTap: () {
                                        //sign out
                                      },
                                    ),
                                  );
                                },
                                height: height * 0.07,
                                width: width,
                                rowMainAxisAlignment: MainAxisAlignment.center,
                                backColor: Colors.red,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.055,
                                ),
                                hMargin: width * 0.07,
                                content: 'تسجيل خروج',
                              ),
                            ],
                          );
                        } else {
                          // If driver data is null, handle it accordingly
                          return Text('Driver data not found.');
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerModel extends StatelessWidget {
  const DrawerModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<DriverModel?>(
      future: LocalStorageService.getDriver(), // Call the getData method asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final DriverModel? driver = snapshot.data;

            if (driver != null) {
              return Drawer(
                width: width * 0.65,
                backgroundColor: Colors.yellowAccent.shade700,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.07),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: CircleAvatar(
                        backgroundImage: const AssetImage('img/driver.png'),
                        backgroundColor: Colors.white,
                        radius: width * 0.2,
                      ),
                    ),
                    Text("${driver.fName} ${driver.lName}",
                        // Use driver's name here
                        style: TextStyle(
                            fontSize: width * 0.08, color: PRIMARY_COLOR)),
                    SizedBox(height: height * 0.03),
                    // ListTile(
                    //   textColor: PRIMARY_COLOR,
                    //   iconColor: PRIMARY_COLOR,
                    //   dense: true,
                    //   title: Text("معلوماتي", style: TextStyle(fontSize: width * 0.04)),
                    //   leading: Icon(IconlyLight.profile, size: width * 0.05),
                    //   shape: UnderlineInputBorder(
                    //       borderRadius: BorderRadius.circular(25),
                    //       borderSide: const BorderSide(width: 2.2)),
                    //   trailing:
                    //       Icon(Icons.arrow_forward_ios_outlined, size: width * 0.05),
                    // ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: UnderlineTabIndicator(
                            insets:
                                EdgeInsets.symmetric(horizontal: width * 0.045),
                            borderSide: const BorderSide(
                                color: PRIMARY_COLOR, width: 1.7)),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(IconlyLight.profile,
                                size: width * 0.05, color: PRIMARY_COLOR),
                            Text("معلوماتي",
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    color: PRIMARY_COLOR)),
                            Icon(Icons.arrow_forward_ios_outlined,
                                size: width * 0.05, color: PRIMARY_COLOR),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const StudentList());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.02),
                        decoration: UnderlineTabIndicator(
                            insets:
                                EdgeInsets.symmetric(horizontal: width * 0.045),
                            borderSide: const BorderSide(
                                color: PRIMARY_COLOR, width: 1.7)),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.task,
                                size: width * 0.05, color: PRIMARY_COLOR),
                            Text("قائمة الطلاب",
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    color: PRIMARY_COLOR)),
                            Icon(Icons.arrow_forward_ios_outlined,
                                size: width * 0.05, color: PRIMARY_COLOR),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          CustomDialog(
                              buttonText: 'نعم',
                              content: 'هل انت متأكد من حالة الطوائ'),
                        );
                      },
                      child: Container(
                        decoration: UnderlineTabIndicator(
                            insets:
                                EdgeInsets.symmetric(horizontal: width * 0.045),
                            borderSide: const BorderSide(
                                color: PRIMARY_COLOR, width: 1.7)),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(IconlyLight.info_circle,
                                size: width * 0.05, color: PRIMARY_COLOR),
                            Text("حالة طوارئ",
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    color: PRIMARY_COLOR)),
                            Icon(Icons.arrow_forward_ios_outlined,
                                size: width * 0.05, color: PRIMARY_COLOR),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text('Driver data not found.');
            }
          }
        }
      },
    );
  }


}
