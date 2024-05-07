import 'dart:async';
import 'dart:ui' as ui;

import 'package:Amin/model/location.dart';
import 'package:Amin/utils/DatabaseHelper.dart';
import 'package:Amin/utils/constant.dart';
import 'package:Amin/utils/map_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestMap extends StatefulWidget {
  @override
  _TestMapState createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  LatLng point1 = const LatLng(24.7407256, 46.6498323);
  LatLng point2 = const LatLng(24.744671, 46.655624);
  LatLng? currentLocation;
  String? busId;
  List<LatLng> polylinePoints = [];
  Uint8List? busMarker;
  BitmapDescriptor? busMarker2;
  late Completer<GoogleMapController> _mapController = Completer();
  late Timer _locationUpdateTimer;
  final _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    loadMarkers();
    //fetchRoute(point1);
    getLocation();
    // Simulate the change of user's location every 5 seconds
    // Replace this with your actual method to get the user's location
  }

  void simulateLocation() {
    _locationUpdateTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      // Here, update currentLocation with the user's new location
      setState(() {
        print("Updating Location11");
        currentLocation = LatLng(
          point2.latitude + 0.0001 * timer.tick,
          point2.longitude + 0.0001 * timer.tick,
        );
      });
      fetchRoute(currentLocation);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getLocation() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('tracking').child('driverId');

    databaseReference.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      //   dataSnapshot = dataSnapshot.value as DataSnapshot;
      print("data");
      print(dataSnapshot);
      DriverLocationModel? driverLocationModel =
          DriverLocationModel.fromSnapshot(dataSnapshot);
      print('data updated');
      print(driverLocationModel.latitude);
      if (driverLocationModel != null) {
        setState(() {
          print("Updating Location");
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
      print("Fetch route");
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
    busMarker = await getBytesFromAsset("img/bus.png", 150);
    busMarker2 =
        await MapHelper.bitmapDescriptorFromSvgAsset("img/bus.svg", size: 35);
    setState(() {}); // Trigger a rebuild after the marker is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تتبع الطالب'),
        centerTitle: true,
      ),
      body: SizedBox(
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

                      icon: busMarker2!, //
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
