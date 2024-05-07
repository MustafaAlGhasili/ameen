import 'package:Amin/utils/general_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/driver_controller.dart';
import '../../../model/driver.dart';
import '../../../model/trip.dart';
import '../../../services/LocalStorageService.dart';
import '../../../utils/constants.dart';
import '../sign/start.dart';
import '../widget/button_model.dart';
import '../widget/custom_dialog.dart';
import 'drawer.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  @override
  Widget build(BuildContext context) {
    Get.put(DriverController());
    DriverController controller = Get.find();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      color: PRIMARY_COLOR,
      onRefresh: () {
        setState(() {});
        return LocalStorageService.getDriver();
      },
      child: Directionality(
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
                    image: const AssetImage('img/logo.png'),
                    height: width * 0.6,
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.62,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(width * 0.1),
                    ),
                  ),
                  child: FutureBuilder<DriverModel?>(
                    future: LocalStorageService.getDriver(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          DriverModel? driver = snapshot.data;

                          if (driver != null) {
                            return Column(
                              children: [
                                SizedBox(height: height * 0.08),
                                Text(
                                  "اهلا بعودتك ${driver.fName} ${driver.lName}",
                                  style: TextStyle(fontSize: width * 0.06),
                                ),
                                FutureBuilder<TripModel?>(
                                  future: LocalStorageService.getTrip(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      print("Checking value: ${controller.isWorking}");
                                      if (snapshot.hasData &&
                                          snapshot.data != null &&
                                          isSameDay(snapshot.data!.createdAt!,
                                              DateTime.now()) &&
                                          !controller.isWorking) {
                                        bool isMorningTrip =
                                            snapshot.data!.type == 1;
                                        print("Trip Home ${snapshot.data!}");

                                        // Show the dialog to choose the trip
                                        return Column(
                                          children: [
                                            isMorningTrip
                                                ? ButtonModel(
                                                    onTap: () {
                                                      Get.dialog(
                                                        CustomDialog(
                                                          buttonText: 'نعم',
                                                          content:
                                                              'هل ترغب في مواصلة رحلة الصباح؟',
                                                          buttonOnTap: () {
                                                            controller
                                                                .createTrip(
                                                                    snapshot
                                                                        .data!
                                                                        .type!);
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    height: height * 0.07,
                                                    width: width,
                                                    rowMainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    backColor: PRIMARY_COLOR,
                                                    vMargin: height * 0.02,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width * 0.055,
                                                    ),
                                                    hMargin: width * 0.07,
                                                    content:
                                                        'مواصلة الرحلة الصباحية',
                                                  )
                                                : ButtonModel(
                                                    onTap: () {
                                                      Get.dialog(
                                                        CustomDialog(
                                                          buttonText:
                                                              'رحلة المساء',
                                                          content:
                                                              'هل ترغب في مواصلة رحلة المساء؟',
                                                          buttonOnTap: () {
                                                            controller
                                                                .createTrip(
                                                                    snapshot
                                                                        .data!
                                                                        .type!);
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    height: height * 0.07,
                                                    width: width,
                                                    rowMainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    backColor: PRIMARY_COLOR,
                                                    vMargin: height * 0.02,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width * 0.055,
                                                    ),
                                                    hMargin: width * 0.07,
                                                    content:
                                                        'مواصلة الرحلة المسائية',
                                                  ),
                                          ],
                                        );
                                      } else {
                                        // If no trip data is available, show the button for creating a trip
                                        return ButtonModel(
                                          onTap: () {
                                            // Handle creating a new trip
                                            print('Creating a new trip');
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
                                                              fontSize: width *
                                                                  0.045),
                                                        ),
                                                        ButtonModel(
                                                          onTap: () {
                                                            controller
                                                                .createTrip(1);
                                                          },
                                                          content:
                                                              'رحلة الصباح',
                                                          backColor:
                                                              PRIMARY_COLOR,
                                                          height: height * 0.05,
                                                          hMargin: width * 0.05,
                                                          rowMainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  width * 0.04),
                                                          vMargin:
                                                              height * 0.015,
                                                        ),
                                                        ButtonModel(
                                                          onTap: () {
                                                            controller
                                                                .createTrip(2);
                                                          },
                                                          content:
                                                              'رحلة المساء',
                                                          backColor:
                                                              PRIMARY_COLOR,
                                                          height: height * 0.05,
                                                          hMargin: width * 0.05,
                                                          rowMainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  width * 0.04),
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
                                          rowMainAxisAlignment:
                                              MainAxisAlignment.center,
                                          backColor: PRIMARY_COLOR,
                                          vMargin: height * 0.02,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.055,
                                          ),
                                          hMargin: width * 0.07,
                                          content: 'ابدأ رحلة جديدة',
                                        );
                                      }
                                    }
                                  },
                                ),
                                ButtonModel(
                                  onTap: () {
                                    Get.dialog(
                                      CustomDialog(
                                        buttonText: 'نعم',
                                        content:
                                            'هل انت متأكد من تسجيل الخروج؟',
                                        buttonOnTap: () async {
                                          await FirebaseAuth.instance.signOut();
                                          Get.offAll(() => const Start());
                                          //sign out
                                        },
                                      ),
                                    );
                                  },
                                  height: height * 0.07,
                                  width: width,
                                  rowMainAxisAlignment:
                                      MainAxisAlignment.center,
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
                            return const Center(
                                child: Text('Driver data not found.'));
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
      ),
    );
  }
}
