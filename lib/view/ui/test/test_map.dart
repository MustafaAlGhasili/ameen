import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const GOOGLE_MAPS_API_KEY = 'AIzaSyBlHVCC3b6bsDxyJAPL7rsdkDarJYd-SeI';

class TestMap extends StatefulWidget {
  @override
  _TestMapState createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  LatLng point1 = const LatLng(24.7407256, 46.6498323);
  LatLng point2 = const LatLng(24.744671, 46.655624);
  List<LatLng> polylinePoints = [];
  late Uint8List customMarker, busMarker;
  late Completer<GoogleMapController> _mapController = Completer();

  final busIcon = const Icon(
    Icons.bus_alert_sharp, // Choose your desired built-in icon
    color: Colors.blue, // Set color (optional)
    size: 48, // Set size (optional)
  );

  Future<void> fetchRoute() async {
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(point1.latitude, point1.longitude),
      PointLatLng(point2.latitude, point2.longitude),
    );

    // Log information about the request
    print("Fetching route from Point 1:");
    print(PointLatLng(point1.latitude, point1.longitude));
    print("to Point 2:");
    print(PointLatLng(point2.latitude, point2.longitude));

    if (result.errorMessage != null) {
      // Log any error message
      print("Error fetching route message: ${result.errorMessage}");
      print("Error fetching route: ${result.points}");
      //  return; // Exit the function early in case of error
    }

    // Log the number of points retrieved
    print("Fetched ${result.points.length} points.");

    // Update the state with decoded points
    if (result.points.isNotEmpty) {
      setState(() {
        this.polylinePoints = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
      moveCameraToCoverPoints();
    } else {
      print('No points found in the route result.');
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

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  loadMarkers() async {
    busMarker = await getImages("img/camera.png", 150);
  }

  @override
  Widget build(BuildContext context) {
    loadMarkers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Line Example'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: point1,
                  zoom: 15.0,
                ),
                myLocationEnabled: true,
                markers: {
                  Marker(
                    markerId: const MarkerId('markerId1'),
                    position: point1,
                    infoWindow: const InfoWindow(
                      title: 'Marker 1',
                      snippet: 'Point 1',
                    ),
                  ),
                  Marker(
                    markerId: const MarkerId('markerId2'),
                    position: point2,
                    icon: BitmapDescriptor.fromBytes(busMarker), //
                    infoWindow: const InfoWindow(
                      title: 'Marker 2',
                      snippet: 'Point 2',
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

                  // Create CameraUpdate with animation
                  final CameraUpdate cameraUpdate =
                      CameraUpdate.newLatLngBounds(
                          bounds, 100); // Add optional padding

                  // Animate the camera to the target bounds
                  await controller.animateCamera(cameraUpdate);
                  fetchRoute();
                }),
            /*  Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: fetchRoute,
                child: const Icon(Icons.directions_car),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
