import 'package:Amin/controller/home_controller.dart';
import 'package:Amin/controller/sign_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/school.dart';
import '../../../model/trip.dart';
import '../../../utils/DatabaseHelper.dart';

class TestFirebase extends StatelessWidget {
  const TestFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    HomeController controller = Get.find();
    SignController signController = Get.find<SignController>();

    Map<String, StudentTripStatus> studentTripStatus = {
      'student1': StudentTripStatus(id: 'student1', status: 0),
      'student2': StudentTripStatus(id: 'student2', status: 1),
      'student3': StudentTripStatus(id: 'student3', status: 2),
    };

    // Create a sample trip
    TripModel trip = TripModel(
      id: '', // Will be generated automatically
      type: 1,
      driverId: 'driver1',
      busId: 'B11',
      createdAt: DateTime.now(),
      studentTripStatus: studentTripStatus,
    );

    final databaseHelper = DatabaseHelper();
    databaseHelper.saveTrip(trip);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: Colors.black,
          elevation: 2,
          centerTitle: true,
          title: Text("الإعدادات", style: TextStyle(fontSize: width * 0.05)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.05),
          child: SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  width: width * 0.9,
                  height: height * 0.06,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "الإشعارات",
                        style: TextStyle(fontSize: width * 0.045),
                      ),
                      Obx(
                        () => Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            activeColor: Colors.white,
                            activeTrackColor:
                                const Color.fromARGB(255, 113, 65, 146),
                            dragStartBehavior: DragStartBehavior.start,
                            inactiveTrackColor: Colors.white,
                            inactiveThumbColor:
                                const Color.fromARGB(255, 113, 65, 146),
                            value: controller.notificationOn.value,
                            onChanged: (val) {
                              controller.notificationOn.value =
                                  !controller.notificationOn.value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    SchoolModel school = SchoolModel(
                      name: 'Example School2',
                      id: 'school1234',
                      address: '@@ May',
                      latitude: 40.7128,
                      longitude: -74.0060,
                    );
                    DatabaseHelper databaseHelper = DatabaseHelper();

                    // Call the saveModel function with the model and the desired reference name
                    await databaseHelper.save<SchoolModel>(school, 'schools');
                    List<SchoolModel> schools = [];
                    schools = await databaseHelper.getAllSchools();

                    print(schools[0].name);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                        )),
                    width: width * 0.9,
                    height: height * 0.06,
                    margin: EdgeInsets.symmetric(vertical: height * 0.03),
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04, vertical: height * 0.01),
                    child: Text(
                      "الدعم",
                      style: TextStyle(fontSize: width * 0.045),
                    ),
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
