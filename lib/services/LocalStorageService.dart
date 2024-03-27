import 'dart:convert';

import 'package:ameen/model/driver.dart';
import 'package:ameen/model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/parent.dart';

class LocalStorageService {
  static const String parentKey = 'parent';
  static const String studentKey = 'student';
  static const String driverKey = 'driver';

  static Future<void> saveParent(ParentModel parent) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final parentJson =
        json.encode(parent.toMap()); // Encode the map to JSON string
    await prefs.setString(parentKey, parentJson);
    print("Saved Parent:");
    print(parentJson);
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
      final Map<String, dynamic> studentMap = json.decode(studentJson);
      return StudentModel.fromMap(studentMap);
    } else {
      return null;
    }
  }

  static void saveUserType(int userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userType', userType);
  }

  static Future<int?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userType');
  }
}
