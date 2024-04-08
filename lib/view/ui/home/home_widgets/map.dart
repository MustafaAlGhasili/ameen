import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Define a single point on the map
    LatLng point1 = const LatLng(24.6583445, 46.6917818);
    LatLng point2 = const LatLng(24.8583445, 46.6917818);

    List<LatLng> polylinePoints = [point1, point2];

    return SizedBox(
      height: height * 0.7,
      width: width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: point1,
          zoom: 15.0, // Set the desired zoom level for the first point
        ),
        myLocationEnabled: true,
        markers: <Marker>{
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
            infoWindow: const InfoWindow(
              title: 'Marker 2',
              snippet: 'Point 2',
            ),
          ),
        },
/*
        polylines: <Polyline>{
          Polyline(
            polylineId: PolylineId('polylineId'),
            points: polylinePoints,
            color: Colors.blue, // Set the color of the polyline
            width: 5, // Set the width of the polyline
          ),
        },
*/
        // Padding is added to ensure the marker is not at the edges of the screen
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}