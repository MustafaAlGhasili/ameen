import 'package:ameen/model/location.dart';
import 'package:ameen/model/parent.dart';
import 'package:ameen/model/student.dart';
import 'package:ameen/model/token.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/admin.dart';
import '../model/driver.dart';
import '../model/school.dart';
import 'data_converter.dart';

class DatabaseHelper {
  final DatabaseReference _rootRef = FirebaseDatabase.instance.ref();

  static final DatabaseReference studentsRef =
      FirebaseDatabase.instance.ref().child('students');
  static final DatabaseReference driverRef =
      FirebaseDatabase.instance.ref().child('drivers');

  Future<String?> save<T extends ToMapConvertible>(
      T model, String refName) async {
    try {
      print("Is being save");
      DatabaseReference newModelRef = _rootRef.child(refName).push();
      String modelId = newModelRef.key ?? '';

      if (model is StudentModel) {
        model.id = modelId!;
      } else if (model is DriverModel) {
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

  Future<void> saveToken(TokenModel tokenModel, String refName) async {
    try {
      print("Is being save");
      print("Token  Id:${tokenModel.userId}");
      DatabaseReference newModelRef =
          _rootRef.child("tokens").child(refName).child(tokenModel.userId!);
      await newModelRef.set(tokenModel.toMap());
    } catch (error) {
      print('Error saving ${tokenModel.toString()}: $error');
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

  Future<void> testRef() async {
    try {

      DataSnapshot snapshot =
          await studentsRef.orderByChild('busId').equalTo('W11').get();
      print("Student Data Try:");

      if (snapshot.exists) {
        print("Data:");
      } else {
        print("No Data");
        return null;
      }
    } catch (error) {
      print('Error getting student by parent ID: $error');
      return null;
    }
  }

  Future<void> deleteById(String id, String refName) async {
    try {
      DatabaseReference modelRef = _rootRef.child(refName).child(id);
      DataSnapshot snapshot = await modelRef.get();
      print('Full Path: ${modelRef.path}');
      if (!snapshot.exists) {
        print('Item with ID: $id does not exist in $refName');
        return;
      }
      await modelRef.remove();
      print('Item with ID: $id deleted from $refName');
    } catch (error) {
      print('Error deleting item with ID $id from $refName: $error');
    }
  }

  Future<List<StudentModel>> getStudentsByBusId(String busId) async {
    try {
      final snapshot = await _rootRef
          .child('students')
          .orderByChild('busId')
          .equalTo(busId)
          .get();

      print(snapshot.value);
      return snapshot.children
          .map((child) => StudentModel.fromSnapshot(child))
          .toList();
    } catch (error) {
      print('Error getting students in bus $busId: $error');
      return [];
    }
  }

  Future<void> updateParentStatus(String parentId, bool isEnabled) async {
    try {
      DatabaseReference parentRef = _rootRef.child('parents').child(parentId);

      await parentRef.update({'isEnabled': isEnabled});

      print('Parent with ID: $parentId - isEnabled updated to: $isEnabled');
    } catch (error) {
      print('Error updating parent isEnabled status: $error');
    }
  }

  Future<int> updateParentStatusByStudentId(
      String studentId, bool isEnabled) async {
    try {
      StudentModel studentModel;
      DataSnapshot studentSnapshot =
          await _rootRef.child('students').child(studentId).get();
      if (studentSnapshot.exists) {
        studentModel = StudentModel.fromSnapshot(studentSnapshot);

        DatabaseReference parentRef =
            _rootRef.child('parents').child(studentModel.parentId);

        await parentRef.update({'isEnabled': isEnabled});

        print('Parent  isEnabled updated to: $isEnabled');
        return 200;
      } else {
        return 404;
      }
    } catch (error) {
      print('Error updating parent isEnabled status: $error');
      return 500;
    }
  }

  Future<void> updateField(
      String reference, String id, String fieldName, String value) async {
    try {
      DatabaseReference ref = _rootRef.child(reference).child(id);
      await ref.update({fieldName: value});

      print('$reference with ID: $id - $fieldName updated to: $value');
    } catch (error) {
      print('Error updating $fieldName status: $error');
    }
  }

  Future<List<StudentModel>> getStudentsOfDisabledParents() async {
    print("I'm Called ");
    DatabaseReference studentsRef = _rootRef.child('students');
    DatabaseReference parentsRef = _rootRef.child('parents');

    final snapshot =
        await parentsRef.orderByChild('isEnabled').equalTo(false).get();
    List<ParentModel> parentList = snapshot.children
        .map((child) => ParentModel.fromSnapshot(child))
        .toList();

    List<StudentModel> studentsOfDisabledParents = [];

    for (ParentModel parent in parentList) {
      final snapshot =
          await studentsRef.orderByChild('parentId').equalTo(parent.id).get();

      List<StudentModel> studentsOfCurrentParent = snapshot.children
          .map((child) => StudentModel.fromSnapshot(child))
          .toList();

      if (studentsOfCurrentParent.isNotEmpty) {
        studentsOfDisabledParents.add(studentsOfCurrentParent.first);
      }
    }
    print("Disabled Data");
    studentsOfDisabledParents.forEach((student) {
      print('Student ID: ${student.id}, Parent ID: ${student.parentId}');
    });

    return studentsOfDisabledParents;
  }



  Future<List<StudentModel>> getStudentsOfEnabledParents() async {
    print("I'm Called ");
    DatabaseReference studentsRef = _rootRef.child('students');
    DatabaseReference parentsRef = _rootRef.child('parents');

    final snapshot =
    await parentsRef.orderByChild('isEnabled').equalTo(true).get();
    List<ParentModel> parentList = snapshot.children
        .map((child) => ParentModel.fromSnapshot(child))
        .toList();

    List<StudentModel> studentsOfDisabledParents = [];

    for (ParentModel parent in parentList) {
      final snapshot =
      await studentsRef.orderByChild('parentId').equalTo(parent.id).get();

      List<StudentModel> studentsOfCurrentParent = snapshot.children
          .map((child) => StudentModel.fromSnapshot(child))
          .toList();

      if (studentsOfCurrentParent.isNotEmpty) {
        studentsOfDisabledParents.add(studentsOfCurrentParent.first);
      }
    }
    print("Disabled Data");
    studentsOfDisabledParents.forEach((student) {
      print('Student ID: ${student.id}, Parent ID: ${student.parentId}');
    });

    return studentsOfDisabledParents;
  }
}
