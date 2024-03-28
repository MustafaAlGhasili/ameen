import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/driver_controller.dart';
import '../../../model/student.dart';
import '../../../model/trip.dart';
import '../map/navigate_map.dart';

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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawer(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          imageUrl: student.imgUrl ?? " ",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
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
                                      style: TextStyle(fontSize: width * 0.045),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return SizedBox(); // Return an empty container if no data is available
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
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final List<StudentModel> students = snapshot.data!;

                      return ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          final StudentModel student = students[index];

                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                                vertical: height * 0.015),
                            decoration: BoxDecoration(
                              color: PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: height * 0.07,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          imageUrl: student.imgUrl ?? " ",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
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
                                      style: TextStyle(
                                          fontSize: width * 0.045,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "1KM",
                                      // Assuming status is part of your StudentModel
                                      style: TextStyle(
                                          fontSize: width * 0.045,
                                          color: Colors.white),
                                    ),
                                    ButtonModel(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => NavigationScreen(
                                                student.latitude!,
                                                student.longitude!,
                                                studentName:
                                                    "${student.fName} ${student.lName}",
                                                addressDescription:
                                                    student.address)));
                                      },
                                      rowMainAxisAlignment:
                                          MainAxisAlignment.center,
                                      hMargin: width * 0.03,
                                      height: height * 0.03,
                                      width: width * 0.15,
                                      content: 'بدء',
                                      backColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return SizedBox(); // Return an empty container if no data is available
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
}

List dis = ['1km', '2km', '3km', '4km'];
List imgs = ['img/img.png', 'img/img2.png', 'img/st1.png', 'img/st2.png'];
List names = ['احمد خالد', 'سارة عبدالعزيز', 'ود احمد', 'هند محمد'];
