import 'package:ameen/services/LocalStorageService.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/driver/drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/driver_controller.dart';
import '../../../model/student.dart';
import '../../../model/trip.dart';
import '../../../utils/constant.dart';
import '../map/navigate_map.dart';
import '../widget/button_model.dart';
import '../widget/cusom_dialog.dart';

DriverController controller = Get.find();

class Trip extends StatefulWidget {
  final int tripType;

  const Trip({Key? key, required this.tripType}) : super(key: key);

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  double width = 0;
  double height = 0;
  String title = "";
  String buttonTitle = "";

  @override
  void initState() {
    super.initState();
    updateUI();
    title = widget.tripType == 2 ? "رحلة المساء" : "رحلة الصباح";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String title = widget.tripType == 2
        ? "رحلة المساء"
        : "رحلة الصباح"; // Set the title based on tripType

    buttonTitle = widget.tripType == 2 ? "إنهاء العمل" : "التوجه إلى المدرسة ";

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const DrawerModel(),
        appBar: AppBar(

          foregroundColor: Colors.white,
          backgroundColor: PRIMARY_COLOR,
          title: Text(title,
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.06,
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(width * 0.03),
                decoration: UnderlineTabIndicator(
                    insets: EdgeInsets.only(left: width * 0.4),
                    borderSide:
                        const BorderSide(color: Colors.black38, width: 1.5)),
                width: width,
                child: Text(
                  'قائمة الطلاب في الباص',
                  style: TextStyle(
                    fontSize: width * 0.06,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.45,
                child: FutureBuilder<List<StudentModel>>(
                  future: controller.getBusStudentsWithStatus(1),
                  // Assuming this function returns a List<StudentModel>
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final List<StudentModel> students = snapshot.data!;
                      if (students.isEmpty) {
                        return Center(
                          child: Text('No students found'),
                        );
                      } else {
                        // Render your list of students here
                        return ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final StudentModel student = students[index];

                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.05,
                                  vertical: height * 0.015),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: height * 0.07,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.white,
                                          child: CachedNetworkImage(
                                            imageUrl: student.imgUrl ?? "",
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Image(
                                                        image: AssetImage(
                                                            "img/st1.png")),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
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
                                      SizedBox(width: width * 0.02),
                                      Text(
                                        '${student.fName} ${student.lName}',
                                        style:
                                            TextStyle(fontSize: width * 0.045),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(width * 0.03),
                decoration: UnderlineTabIndicator(
                    insets: EdgeInsets.only(left: width * 0.4),
                    borderSide:
                        const BorderSide(color: Colors.black38, width: 1.5)),
                width: width,
                child: Text(
                  'قائمة انتظار الطلاب',
                  style: TextStyle(
                    fontSize: width * 0.06,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.45,
                child: FutureBuilder<List<StudentModel>>(
                  future: controller.getBusStudentsWithStatus(0),
                  // Assuming this function returns a List<StudentModel>
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final List<StudentModel> students = snapshot.data!;
                      if (students.isEmpty) {
                        return Center(
                          child: ButtonModel(
                            onTap: () async {
                              if (widget.tripType == 1) {
                                await launchUrl(Uri.parse('google.navigation:q=24.7851092,46.5693527&key=${Constants.GOOGLE_MAPS_API_KEY}'));
                              } else {
                                Get.dialog(
                                  CustomDialog(
                                    buttonText: "انهاء العمل",
                                    content: "الرجاء التحقق من المركبة",
                                    buttonOnTap: () async {
                                      await LocalStorageService.saveTrip(null);
                                      Get.back();
                                    },
                                  ),
                                );
                              }
                            },
                            hMargin: width * 0.05,
                            style: const TextStyle(color: Colors.white),
                            rowMainAxisAlignment: MainAxisAlignment.center,
                            content: buttonTitle,
                            backColor: PRIMARY_COLOR,
                            height: height * 0.07,
                          ),
                        );
                      } else {
                        // Render your list of students here
                        return ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final StudentModel student = students[index];
                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                                vertical: height * 0.015,
                              ),
                              decoration: BoxDecoration(
                                color: PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: height * 0.07,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            child: CachedNetworkImage(
                                              imageUrl: student.imgUrl ?? " ",
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget: (context, url, error) =>
                                              const Image(image: AssetImage("img/st1.png")),
                                              imageBuilder: (context, imageProvider) =>
                                                  Container(
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
                                        SizedBox(width: width * 0.02),
                                        Text(
                                          '${student.fName} ${student.lName}',
                                          style: TextStyle(fontSize: width * 0.045, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FutureBuilder<double>(
                                    future: _calculateDistance(student.latitude!, student.longitude!),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        // Handle loading state
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasData) {
                                        // Distance calculation successful
                                        double distanceInKm = snapshot.data!;
                                        return Text(
                                          '${distanceInKm.toStringAsFixed(2)} كم',
                                          style: TextStyle(fontSize: width * 0.035, color: Colors.white),
                                        );
                                      } else {
                                        // Handle error state
                                        return Text('Error calculating distance');
                                      }
                                    },
                                  ),
                                  ButtonModel(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => NavigationScreen(
                                          student: student,
                                          tripId: controller.tripId!,
                                        ),
                                      ));
                                    },
                                    rowMainAxisAlignment: MainAxisAlignment.center,
                                    hMargin: width * 0.03,
                                    height: height * 0.03,
                                    width: width * 0.15,
                                    content: 'بدء',
                                    backColor: Colors.white,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                    // Add a default return statement to ensure a non-nullable Widget is returned
                    return SizedBox(); // You can return an empty SizedBox or any other appropriate Widget
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateUI() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child('trips')
        .child(controller.tripId!);

    databaseReference.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      print("data");
      print(dataSnapshot);
      final result = TripModel?.fromSnapshot(dataSnapshot);
      print('data updated');
      if (result != null) {
        print(result.status);

        setState(() {
          print("Updating Location");
        });
      }
    });
  }

  Future<void> test() async {
    TripModel? trip = await controller.testing("-Nu1fYZFvMBHsiMcckPN");
    if (trip != null) {
      print("Updated${trip.busId}");
      // Trip data is available
    } else {
      print("Updated no data");
    }
  }

  Future<double> _calculateDistance(double latitude, double longitude) async {
    // Get current location
    Position currentPosition = await Geolocator.getCurrentPosition();

    // Calculate distance between current location and the provided coordinates
    double distanceInMeters = await Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      latitude,
      longitude,
    );

    // Convert distance from meters to kilometers
    double distanceInKm = distanceInMeters / 1000;

    return distanceInKm;
  }
}
