import 'dart:async';
import 'dart:ui' as ui;

import 'package:ameen/model/location.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:ameen/utils/constant.dart';
import 'package:ameen/utils/map_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'navigation.dart';

class TestMapUber extends StatefulWidget {
  @override
  _TestMapUberState createState() => _TestMapUberState();
}

class _TestMapUberState extends State<TestMapUber> {
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter uber'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Enter your location',
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: latController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'latitude',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: lngController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'longitute',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NavigationScreen(
                         // double.parse(latController.text),
                         // double.parse(lngController.text)
                          15.3546934,44.163375
                      )));
                },
                child: Text('Get Directions')),
          ),
        ]),
      ),
    );
  }
}