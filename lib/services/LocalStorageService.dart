import 'dart:convert';

import 'package:ameen/model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/parent.dart';

class LocalStorageService {
  static const String parentKey = 'parent';
  static const String studentKey = 'student';

  static Future<void> saveParent(ParentModel parent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(parentKey, parent.toMap().toString());
  }

  static Future<ParentModel?> getParent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? parentString = prefs.getString(parentKey);
    print('object $parentString');
    if (parentString != null && parentString.isNotEmpty) {
      Map<String, dynamic> parentMap =
          Map.castFrom<dynamic, dynamic, String, dynamic>(
              Map<String, dynamic>.from(json.decode(parentString)));
      return ParentModel.fromMap(parentMap);
    } else {
      return null;
    }
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
