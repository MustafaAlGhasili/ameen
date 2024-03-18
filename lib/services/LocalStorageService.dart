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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final studentJson = json.encode(student.toMap()); // Encode the map to JSON string
    await prefs.setString(studentKey, studentJson);
    print("Saved student:");
    print(studentJson);
  }

  static Future<StudentModel?> getStudent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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
