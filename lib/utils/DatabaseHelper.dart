import 'package:ameen/model/location.dart';
import 'package:ameen/model/parent.dart';
import 'package:ameen/model/student.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/admin.dart';
import '../model/school.dart';
import 'data_converter.dart';

class DatabaseHelper {
  final DatabaseReference _rootRef = FirebaseDatabase.instance.ref();

  Future<String?> save<T extends ToMapConvertible>(
      T model, String refName) async {
    try {
      print("Is being save");
      DatabaseReference newModelRef = _rootRef.child(refName).push();
      String modelId = newModelRef.key ?? '';

      if (model is StudentModel) {
        model.id = modelId!;
      }
      await newModelRef.set(model.toMap());

      print('${T.toString()} saved successfully with ID: $modelId');
      return modelId;
    } catch (error) {
      print('Error saving ${T.toString()}: $error');
      return null;
    }
  }

  Future<String?> saveParent(ParentModel parentModel, String refName) async {
    try {
      print("Is being save");
      print("Parent Id:${parentModel.id}");
      DatabaseReference newModelRef =
          _rootRef.child(refName).child(parentModel.id);
      await newModelRef.set(parentModel.toMap());

      return parentModel.id;
    } catch (error) {
      print('Error saving ${parentModel.toString()}: $error');
      return null;
    }
  }

  Future<void> saveDriverLocation(
      DriverLocationModel driverLocationModel, String refName) async {
    try {
      print("Is being save");
      print("Driver Id:${driverLocationModel.driverId}");
      DatabaseReference newModelRef =
          _rootRef.child(refName).child(driverLocationModel.driverId);
      await newModelRef.set(driverLocationModel.toMap());
    } catch (error) {
      print('Error saving ${driverLocationModel.toString()}: $error');
    }
  }

  Future<List<SchoolModel>> getAllSchools() async {
    try {
      final snapshot = await _rootRef.child('schools').get();
      return snapshot.children
          .map((child) => SchoolModel.fromSnapshot(child))
          .toList();
    } catch (error) {
      print('Error getting schools: $error');
      return [];
    }
  }

  Future<T?> getUserById<T extends ToMapConvertible>(
      String userId, int loginType) async {
    try {
      if (loginType == 0) {
        DataSnapshot parentSnapshot =
            await _rootRef.child('parents').child(userId).get();
        if (parentSnapshot.exists) {
          return ParentModel.fromSnapshot(parentSnapshot) as T?;
        }
      } else if (loginType == 1) {
        DataSnapshot driverSnapshot =
            await _rootRef.child('drivers').child(userId).get();
        if (driverSnapshot.exists) {
          // return DriverModel.fromSnapshot(driverSnapshot) as T?;
        }
      } else {
        DataSnapshot adminSnapshot =
            await _rootRef.child('admins').child(userId).get();
        if (adminSnapshot.exists) {
          return AdminModel.fromSnapshot(adminSnapshot) as T?;
        }
      }

      return null;
    } catch (error) {
      print('Error getting user: $error');
      return null;
    }
  }

  Future<StudentModel?> getStudentByParentId(String parentId) async {
    try {
      DataSnapshot studentSnapshot = await _rootRef
          .child('students')
          .orderByChild('parentId')
          .equalTo(parentId)
          .get();

      print("Student Data Try:");

      if (studentSnapshot.exists) {
        // Ensure studentSnapshot.value is not null before accessing values
        if (studentSnapshot.value != null) {
          print("Student Data:");
          print(studentSnapshot.value);
          // Map<String, dynamic> studentData = studentSnapshot.value.values.first;
          // return StudentModel.fromMap(studentData);
          return null;
        } else {
          // Handle the case where studentSnapshot.value is unexpectedly null
          print("Unexpected data structure: studentSnapshot.value is null");
          return null;
        }
      } else {
        // Not found
        return null;
      }
    } catch (error) {
      print('Error getting student by parent ID: $error');
      return null;
    }
  }
}
