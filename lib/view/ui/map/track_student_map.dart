import 'dart:async';
import 'dart:ui' as ui;

import 'package:Amin/model/location.dart';
import 'package:Amin/model/student.dart';
import 'package:Amin/services/LocalStorageService.dart';
import 'package:Amin/utils/DatabaseHelper.dart';
import 'package:Amin/utils/constant.dart';
import 'package:Amin/utils/map_helper.dart';
import 'package:Amin/view/ui/home/info/info_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackStudentMap extends StatefulWidget {
  @override
  _TrackStudentMapState createState() => _TrackStudentMapState();
}

class _TrackStudentMapState extends State<TrackStudentMap> {
  LatLng point1 = const LatLng(24.7407256, 46.6498323);
  LatLng point2 = const LatLng(24.744671, 46.655624);
  LatLng? currentLocation;
  String studentName = ''; // Provide a default value
  String? busId;
  List<LatLng> polylinePoints = [];
  Uint8List? busMarker;
  BitmapDescriptor? busMarker2;
  StudentModel? studentModel;
  late Completer<GoogleMapController> _mapController = Completer();
  final _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    fetchStudentLocation();
    loadMarkers();
  }

  Future<void> fetchStudentLocation() async {
    try {
      final student = await LocalStorageService.getStudent();
      studentModel = student;
      print("studentModel  in Map $studentModel");
      if (student != null) {

        setState(() {
          point1 = LatLng(student.latitude ?? 0, student.longitude ?? 0);
          studentName = "${student.fName} ${student.lName}";
        });
        getLocation();

      } else {
        print("Student data not found in local storage");
      }
    } catch (error) {
      print("Error fetching student location: $error");
    }
  }

  void getLocation() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('tracking').child(studentModel!.busId!);

    databaseReference.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      DriverLocationModel? driverLocationModel =
          DriverLocationModel.fromSnapshot(dataSnapshot);
      if (driverLocationModel != null) {
        setState(() {
          busId = driverLocationModel.busId;
          currentLocation = LatLng(
            driverLocationModel.latitude,
            driverLocationModel.longitude,
          );
        });
        fetchRoute(currentLocation);
      }
    });
  }

  Future<void> fetchRoute(LatLng? currentLocation) async {
    if (currentLocation != null) {
      try {
        final polylinePoints = PolylinePoints();

        final result = await polylinePoints.getRouteBetweenCoordinates(
          Constants.GOOGLE_MAPS_API_KEY,
          PointLatLng(point1.latitude, point1.longitude),
          PointLatLng(currentLocation.latitude, currentLocation.longitude),
        );

        if (result.points.isNotEmpty) {
          setState(() {
            this.polylinePoints = result.points
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList();
          });
          moveCameraToCoverPoints();
        } else {
          print('Fetching route: No points found in the route result.');
        }
      } catch (error) {
        print("Error fetching route: $error");
      }
    }
  }

  void moveCameraToCoverPoints() {
    if (_mapController.isCompleted) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          polylinePoints.first.latitude,
          polylinePoints.first.longitude,
        ),
        northeast: LatLng(
          polylinePoints.last.latitude,
          polylinePoints.last.longitude,
        ),
      );

      _mapController.future.then((controller) {
        controller.animateCamera(CameraUpdate.newLatLngBounds(
          bounds,
          50.0, // padding
        ));
      });
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  loadMarkers() async {
    try {
      busMarker = await getBytesFromAsset("img/bus.png", 150);
      busMarker2 =
          await MapHelper.bitmapDescriptorFromSvgAsset("img/bus.svg", size: 35);
      setState(() {}); // Trigger a rebuild after the marker is loaded
    } catch (error) {
      print("Error loading markers: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('  تتبع الطالب ($studentName)'),
        centerTitle: true,
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  if (busMarker2 != null)
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: currentLocation ?? point1,
                        zoom: 15.0,
                      ),
                      myLocationEnabled: true,
                      markers: {
                        Marker(
                          markerId: const MarkerId('markerId1'),
                          position: point1,
                          icon: BitmapDescriptor.defaultMarker,
                          infoWindow: const InfoWindow(
                            title: 'Marker 1',
                            snippet: 'Point 1',
                          ),
                        ),
                        if (polylinePoints.isNotEmpty)
                          Marker(
                            markerId: const MarkerId('markerId2'),
                            position: currentLocation ?? point2,
                            icon: busMarker2!,
                            infoWindow: InfoWindow(
                              title: 'Bus',
                              snippet: busId ?? 'Point 2',
                            ),
                          ),
                      },
                      polylines: {
                        if (polylinePoints.isNotEmpty)
                          Polyline(
                            polylineId: const PolylineId('routeLine'),
                            color: const Color.fromARGB(255, 113, 65, 146),
                            width: 5,
                            points: polylinePoints,
                          ),
                      },
                      padding: const EdgeInsets.all(20.0),
                      onMapCreated: (GoogleMapController controller) async {
                        LatLngBounds bounds = LatLngBounds(
                          southwest: LatLng(
                            polylinePoints.first.latitude,
                            polylinePoints.first.longitude,
                          ),
                          northeast: LatLng(
                            polylinePoints.last.latitude,
                            polylinePoints.last.longitude,
                          ),
                        );

                        final CameraUpdate cameraUpdate =
                            CameraUpdate.newLatLngBounds(bounds, 100);

                        await controller.animateCamera(cameraUpdate);
                      },
                    ),
                ],
              ),
            ),
    );
  }
}
