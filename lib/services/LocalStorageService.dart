import 'dart:convert';

import 'package:ameen/model/driver.dart';
import 'package:ameen/model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/parent.dart';
import '../model/trip.dart';

class LocalStorageService {
  static const String parentKey = 'parent';
  static const String studentKey = 'student';
  static const String driverKey = 'driver';
  static const String tripKey = 'trip';

  static Future<void> saveParent(ParentModel parent) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final parentJson =
        json.encode(parent.toMap()); // Encode the map to JSON string
    await prefs.setString(parentKey, parentJson);
    print("Saved Parent:");
    print(parentJson);
  }

  void updateParent(ParentModel parent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Serialize model to JSON
    String jsonModel = jsonEncode(parent.toJson());

    // Store serialized JSON string in SharedPreferences
    await prefs.setString(parentKey, jsonModel);
  }


  static Future<void> saveDriver(DriverModel driver) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final parentJson =
        json.encode(driver.toMap()); // Encode the map to JSON string
    await prefs.setString(driverKey, parentJson);
    print("Saved Driver to Local:");
    print(parentJson);
  }

  static Future<void> saveStudent(StudentModel student) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final studentJson = json.encode(student.toMap());
    await prefs.setString(studentKey, studentJson);
    print("Saved Student:");
    print(studentJson);
  }

  static Future<ParentModel?> getParent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final parentJson = prefs.getString(parentKey);
    if (parentJson != null) {
      final Map<String, dynamic> parentMap = json.decode(parentJson);
      return ParentModel.fromMap(parentMap);
    }
    return null;
  }

  static Future<DriverModel?> getDriver() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final driverJson = prefs.getString(driverKey);
    if (driverJson != null) {
      final Map<String, dynamic> driverMap = json.decode(driverJson);
      return DriverModel.fromMap(driverMap);
    }
    return null;
  }

  static Future<StudentModel?> getStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final studentJson = prefs.getString(studentKey);

    if (studentJson != null) {
      print("Found student in local: $studentJson");
      final Map<String, dynamic> studentMap = json.decode(studentJson);
      return StudentModel.fromMap(studentMap);
    } else {
      print("Not Found student in local");

      return null;
    }
  }

  static Future updateData()async {

  }

  static void saveUserType(int userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userType', userType);
  }

  static Future<int?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userType');
  }

  static Future<TripModel?> getTrip() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final tripJson = prefs.getString(tripKey);

      print("Local Trip Data: $tripJson");

      if (tripJson != null) {
        final Map<String, dynamic> tripMap = json.decode(tripJson);
        return TripModel.fromMap(tripMap);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching local trip: $e");
      return null;
    }
  }

  static Future<void> saveTrip(TripModel? trip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final tripJson = json.encode(trip!.toMap());
    await prefs.setString(tripKey, tripJson);
    print("Saved trip:");
    print(tripJson);
  }



}
