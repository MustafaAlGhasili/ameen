import 'dart:async';

import 'package:ameen/model/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/DatabaseHelper.dart';

const GOOGLE_MAPS_API_KEY = 'AIzaSyBlHVCC3b6bsDxyJAPL7rsdkDarJYd-SeI';

class TestMapTracking extends StatefulWidget {
  @override
  _TestMapTrackingState createState() => _TestMapTrackingState();
}

class _TestMapTrackingState extends State<TestMapTracking> {
  LatLng source = const LatLng(24.7407256, 46.6498323);
  LatLng destination = const LatLng(24.744671, 46.655624);
  List<LatLng> polylinePoints = [];
  late Uint8List customMarker, busMarker;
  late Completer<GoogleMapController> _controller = Completer();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<LatLng> polylineCoordinates = [];
  Position? currentLocation;

  void getPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    // Log information about the request

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
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    } else {
      print('No points found in the route result.');
    }
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  void getCurrentLocation() async {
    bool hasPermission = await _checkLocationPermission();
    if (!hasPermission) {
      // Permission denied, show a dialog to request again
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Location Permission Required'),
          content:
              Text('This app needs location access to track your location.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _checkLocationPermission(); // Retry requesting permission
                // If permission is still denied after retry (rare case), inform user
                if (!await _checkLocationPermission()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Location permission is still denied. You can enable it from Settings.'),
                    ),
                  );
                } else {
                  getCurrentLocation(); // Retry getting location if permission granted
                }
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    currentLocation = position;

    print("currentLocation1");
    print(currentLocation);

    GoogleMapController googleMapController = await _controller.future;

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream().listen((newLoc) {
      currentLocation = newLoc;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 15.5,
            target: LatLng(
              newLoc.latitude,
              newLoc.longitude,
            ),
          ),
        ),
      );
      print("currentLocation2");
      print(currentLocation);

      if (currentLocation != null) {
        final timestamp = DateTime.now().toIso8601String();
        final driverLocation = DriverLocationModel(
            driverId: "driverId",
            latitude: currentLocation!.latitude,
            longitude: currentLocation!.longitude,
            timestamp: timestamp);

        _databaseHelper.saveDriverLocation(driverLocation, "tracking");
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolylinePoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking '),
      ),
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: source,
                      zoom: 15.5,
                    ),
                    polylines: {
                      if (polylineCoordinates.isNotEmpty)
                        Polyline(
                          polylineId: const PolylineId('routeLine'),
                          color: const Color.fromARGB(255, 113, 65, 146),
                          width: 6,
                          points: polylineCoordinates,
                        ),
                    },
                    myLocationEnabled: true,
                    markers: {
                      Marker(
                        markerId: const MarkerId('markerId1'),
                        position: source,
                        infoWindow: const InfoWindow(
                          title: 'Marker 1',
                          snippet: 'Point 1',
                        ),
                      ),
                      Marker(
                        markerId: const MarkerId('markerId2'),
                        position: destination,
                        infoWindow: const InfoWindow(
                          title: 'Marker 2',
                          snippet: 'Point 2',
                        ),
                      ),
                      Marker(
                        markerId: const MarkerId('markerId3'),
                        position: LatLng(currentLocation!.latitude,
                            currentLocation!.longitude),
                        infoWindow: const InfoWindow(
                          title: 'Current',
                          snippet: 'Point 2',
                        ),
                      ),
                    },
                    padding: const EdgeInsets.all(20.0),
                    onMapCreated: (mapController) {
                      _controller.complete(mapController);
                    },
                  )
                ],
              ),
            ),
    );
  }
}
