import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MyLocationPickerPage2 extends StatefulWidget {
  @override
  _MyLocationPickerPage2State createState() => _MyLocationPickerPage2State();
}

class _MyLocationPickerPage2State extends State<MyLocationPickerPage2> {
  Future<void> getLocation() async {
    if (await _requestPermission()) {
      LocationResult? result = await showLocationPicker(
        context,
        "AIzaSyBlHVCC3b6bsDxyJAPL7rsdkDarJYd-SeI",
        initialCenter: const LatLng(40.7128, -74.0060),
        layersButtonEnabled: true,
        automaticallyAnimateToCurrentLocation: true,
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        language: 'en',
        countries: ['US'],
        requiredGPS: true,
        searchBarBoxDecoration: null, // Set searchBarBoxDecoration to null to hide the search bar

      );

      if (result != null) {
        print("Selected location:");
        print("Address: ${result.address}");
        print("LatLng: ${result.latLng.latitude}, ${result.latLng.longitude}");
      } else {
        print("Location picking canceled");
      }
    } else {
      print("Permission denied");
    }
  }

  Future<bool> _requestPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status == PermissionStatus.granted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Picker Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: getLocation,
          child: Text("Pick Location"),
        ),
      ),
    );
  }
}
