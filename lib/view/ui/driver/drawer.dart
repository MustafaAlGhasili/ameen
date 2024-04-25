import 'package:ameen/view/ui/admin/drivers/driver_presoanl_info.dart';
import 'package:ameen/view/ui/driver/student/student_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../model/driver.dart';
import '../../../services/LocalStorageService.dart';
import '../../../utils/constants.dart';
import '../widget/custom_dialog.dart';

class DrawerModel extends StatelessWidget {
  const DrawerModel({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<DriverModel?>(
      future: LocalStorageService.getDriver(),
      // Call the getData method asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
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
                        backgroundColor: Colors.white,
                        radius: width * 0.2,
                        child: CachedNetworkImage(
                          imageUrl: driver.photo ?? " ",
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
                    Text("${driver.fName} ${driver.lName}",
                        style: TextStyle(
                            fontSize: width * 0.08, color: PRIMARY_COLOR)),
                    SizedBox(height: height * 0.03),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => DriverPInfo(
                              driver: driver,
                            ));
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
                        print(driver.busId);
                        Get.to(() => StudentList(busId: driver.busId));
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
                              buttonOnTap: () {},
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
              return const Text('Driver data not found.');
            }
          }
        }
      },
    );
  }
}
