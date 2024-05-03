import 'dart:async';
import 'dart:isolate';
import 'dart:math' show cos, sqrt, asin;
import 'dart:ui';

import 'package:ameen/model/trip.dart';
import 'package:ameen/utils/constant.dart';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart'
    as settings;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:location_permissions/location_permissions.dart' as loc2;
import 'package:url_launcher/url_launcher.dart';

import '../../../model/location.dart';
import '../../../model/student.dart';
import '../../../utils/DatabaseHelper.dart';
import '../../../utils/constants.dart';
import '../widget/button_model.dart';
import '../widget/custom_dialog.dart';
import 'file_manager.dart';
import 'location_handler.dart';
import 'location_service_repository.dart';

class NavigationScreen extends StatefulWidget {
  final StudentModel student;
  final TripModel trip;

  const NavigationScreen({
    super.key,
    required this.student,
    required this.trip,
  });

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  LatLng curLocation = const LatLng(15.3546934, 44.163375);
  StreamSubscription<loc.LocationData>? locationSubscription;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  ReceivePort port = ReceivePort();

  String logStr = '';
  bool? isRunning;
  LocationDto? lastLocation;

  @override
  void initState() {
    super.initState();

    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);

    port.listen(
      (dynamic data) async {
        await updateUI(data);
      },
    );
    initPlatformState();
    getNavigation();
    addMarker();
    _onStart();
  }

  void onStop() async {
    await BackgroundLocator.unRegisterLocationUpdate();
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> updateUI(dynamic data) async {
    //final log = await FileManager.readLogFile();

    LocationDto? locationDto =
        (data != null) ? LocationDto.fromJson(data) : null;
    await _updateNotificationText(locationDto!);
    print("Tracking ");
    print(locationDto);

    final timestamp = DateTime.now().toIso8601String();
    final driverLocation = DriverLocationModel(
        driverId: widget.trip.driverId!,
        busId: widget.trip.busId!,
        latitude: locationDto.latitude,
        longitude: locationDto.longitude,
        timestamp: timestamp);

    _databaseHelper.saveDriverLocation(driverLocation, "tracking");

    if (mounted) {
      setState(() {
        if (data != null) {
          lastLocation = locationDto;
        }
      });
    }
  }

  Future<void> _updateNotificationText(LocationDto data) async {
    // ignore: unnecessary_null_comparison
    if (data == null) {
      return;
    }

    await BackgroundLocator.updateNotificationText(
        title: "new location received",
        msg: "${DateTime.now()}",
        bigMsg: "${data.latitude}, ${data.longitude}");
  }

  Future<void> initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();
    logStr = await FileManager.readLogFile();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
    print('Running ${isRunning.toString()}');
  }

  void _onStart() async {
    print("Starting BackService");
    if (await _checkLocationPermission()) {
      await _startLocator();
      final _isRunning = await BackgroundLocator.isServiceRunning();

      setState(() {
        isRunning = _isRunning;
        lastLocation = null;
      });
      print("Granted BackService");
      print("Running BackService:$isRunning");
    } else {
      // show error
      print("Not Granted BackService");
    }
  }

  Future<bool> _checkLocationPermission() async {
    final access = await loc2.LocationPermissions().checkPermissionStatus();
    switch (access) {
      case loc2.PermissionStatus.unknown:
      case loc2.PermissionStatus.denied:
      case loc2.PermissionStatus.restricted:
        final permission = await loc2.LocationPermissions().requestPermissions(
          permissionLevel: loc2.LocationPermissionLevel.locationAlways,
        );
        print(loc2.PermissionStatus.granted);
        if (permission == loc2.PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }

      case loc2.PermissionStatus.granted:
        return true;

      default:
        return false;
    }
  }

  Future<void> _startLocator() async {
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(
        LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: data,
        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings: IOSSettings(
            accuracy: settings.LocationAccuracy.NAVIGATION,
            distanceFilter: 0,
            stopWithTerminate: true),
        autoStop: false,
        androidSettings: const AndroidSettings(
            accuracy: settings.LocationAccuracy.NAVIGATION,
            interval: 5,
            distanceFilter: 0,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                    LocationCallbackHandler.notificationCallback)));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl, // Set the text direction to RTL
      child: Scaffold(
        body: sourcePosition == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    polylines: Set<Polyline>.of(polylines.values),
                    initialCameraPosition: CameraPosition(
                      target: curLocation,
                      zoom: 16,
                    ),
                    markers: {sourcePosition!, destinationPosition!},
                    onTap: (latLng) {
                      print(latLng);
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Positioned(
                    top: 30,
                    left: 15,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        padding: EdgeInsets.all(width * 0.05),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: width * 0.08,
                                      child: const Image(
                                        image: AssetImage('img/img.png'),
                                      ),
                                    ),
                                    SizedBox(width: width * 0.04),
                                    Text(
                                      "${widget.student.fName} ${widget.student.lName}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.05),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${double.parse((getDistance(LatLng(widget.student.latitude!, widget.student.longitude!)).toStringAsFixed(2)))} كم',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.045),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.01),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(width * 0.04),
                              child: Center(
                                child: Text(
                                  widget.student.address,
                                  style: TextStyle(fontSize: width * 0.045),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    // Adjust the horizontal margin as needed
                                    child: SizedBox(
                                      height: height * 0.07,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          textStyle: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          problemDialog(context);
                                        },
                                        icon: const Icon(Icons.warning),
                                        label: const Text('تواجه مشكلة ؟'),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    // Adjust the horizontal margin as needed
                                    child: SizedBox(
                                      height: height * 0.07,
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          _onStart();
                                          await launchUrl(Uri.parse(
                                              'google.navigation:q=${widget.student.latitude}, ${widget.student.longitude}&key=${Constants.GOOGLE_MAPS_API_KEY}'));
                                        },
                                        icon: const Icon(Icons.map),
                                        label: const Text('عرض المسار'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void problemDialog(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Get.dialog(Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: height * 0.3,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.015,
            ),
            Text(
              "تواجهة مشكلة ؟",
              style: TextStyle(fontSize: width * 0.05),
            ),
            SizedBox(height: height * 0.01),
            ButtonModel(
              onTap: () {
                navigator?.pop();
                Get.dialog(
                  CustomDialog(
                    buttonText: 'هل أنت متأكد؟',
                    content: 'نعم',
                    buttonOnTap: () async {
                      Get.dialog(
                        const AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text('جارٍ التسجيل...'),
                            ],
                          ),
                        ),
                        barrierDismissible:
                            false, // Prevent dismissing dialog by tapping outside
                      );
                      final databaseHelper = DatabaseHelper();
                      await databaseHelper.makeManualAttendance(
                          widget.trip.id!, widget.student.id, 4);
                      Get.back();
                      navigator?.pop();
                      Get.back();
                    },
                  ),
                );
              },
              hMargin: width * 0.04,
              height: height * 0.06,
              content: 'الطالب لم ياتي',
              rowMainAxisAlignment: MainAxisAlignment.center,
              backColor: PRIMARY_COLOR,
              style: TextStyle(color: Colors.white, fontSize: width * 0.05),
            ),
            ButtonModel(
              onTap: () {
                navigator?.pop();
                Get.dialog(
                  CustomDialog(
                    buttonText: 'هل أنت متأكد؟',
                    content: 'نعم',
                    buttonOnTap: () async {
                      Get.dialog(
                        const AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text('جارٍ تسجيل الحضور...'),
                            ],
                          ),
                        ),
                        barrierDismissible:
                            false, // Prevent dismissing dialog by tapping outside
                      );
                      final databaseHelper = DatabaseHelper();
                      await databaseHelper.makeManualAttendance(
                          widget.trip.id!, widget.student.id, 1);
                      Get.back();
                      navigator?.pop();
                      Get.back();
                    },
                  ),
                );
              },
              hMargin: width * 0.04,
              vMargin: height * 0.015,
              height: height * 0.06,
              content: 'تسجيل الحضور يدويا',
              rowMainAxisAlignment: MainAxisAlignment.center,
              backColor: PRIMARY_COLOR,
              style: TextStyle(color: Colors.white, fontSize: width * 0.05),
            ),
            ButtonModel(
              onTap: () {
                launchUrl(Uri(scheme: 'tel', path: '911'));
              },
              hMargin: width * 0.04,
              height: height * 0.06,
              content: 'الاتصال بالمشرف',
              rowMainAxisAlignment: MainAxisAlignment.center,
              backColor: PRIMARY_COLOR,
              style: TextStyle(color: Colors.white, fontSize: width * 0.05),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> getNavigation() async {
    print("Adding Nav");
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    print("Location Enabled: $_serviceEnabled");

    if (_permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = _locationData;
      curLocation =
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
        if (currentLocation.longitude != null) {
          print(
              'Current location: ${currentLocation.latitude}, ${currentLocation.longitude}');
        }
        controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 16,
        )));
        if (mounted) {
          controller
              ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
          setState(() {
            curLocation =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            sourcePosition = Marker(
              markerId: const MarkerId('source'),
              // Use a fixed ID for source marker
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              infoWindow: InfoWindow(
                title:
                    '${double.parse((getDistance(LatLng(widget.student.latitude!, widget.student.longitude!)).toStringAsFixed(2)))} km',
              ),
              onTap: () {
                print('market tapped');
              },
            );
          });
          getDirections(
              LatLng(widget.student.latitude!, widget.student.longitude!));
        }
      });
    }
  }

  getDirections(LatLng dst) async {
    print("Adding Dir");
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.GOOGLE_MAPS_API_KEY,
        PointLatLng(curLocation.latitude, curLocation.longitude),
        PointLatLng(dst.latitude, dst.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double getDistance(LatLng destposition) {
    print("Adding Distance");
    return calculateDistance(curLocation.latitude, curLocation.longitude,
        destposition.latitude, destposition.longitude);
  }

  addMarker() {
    print("Adding marker");
    setState(() {
      sourcePosition = Marker(
        markerId: const MarkerId('source'),
        position: curLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
      destinationPosition = Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(widget.student.latitude!, widget.student.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(title: widget.student.fName),
      );
    });
  }
}
