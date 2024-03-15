import 'dart:convert';

import 'package:ameen/model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/parent.dart';

class LocalStorageService {
  static const String parentKey = 'parent';
  static const String studentKey = 'student';

  static Future<void> saveParent(ParentModel parent) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final parentJson = json.encode(parent.toMap()); // Encode the map to JSON string
    await prefs.setString(parentKey, parentJson);
    print("Saved Parent:");
    print(parentJson);
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

  static Future<void> saveStudent(StudentModel student) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(studentKey, student.toMap().toString());
  }

  static Future<StudentModel?> getStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentString = prefs.getString(studentKey);

    if (studentString != null && studentString.isNotEmpty) {
      Map<String, dynamic> studentMap =
          Map.castFrom<dynamic, dynamic, String, dynamic>(
              Map<String, dynamic>.from(json.decode(studentString)));
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
