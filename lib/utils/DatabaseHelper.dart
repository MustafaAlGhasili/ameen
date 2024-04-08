import 'package:ameen/model/location.dart';
import 'package:ameen/model/parent.dart';
import 'package:ameen/model/student.dart';
import 'package:ameen/model/token.dart';
import 'package:ameen/model/trip.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart'; // Import DateFormat for date formatting

import '../model/admin.dart';
import '../model/driver.dart';
import '../model/notificationModel.dart';
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

  Future<String?> saveDriver(DriverModel driverModel, String refName) async {
    try {
      print("Is being save");
      print("Driver Id:${driverModel.id}");
      DatabaseReference newModelRef =
          _rootRef.child(refName).child(driverModel.id);
      await newModelRef.set(driverModel.toMap());

      return driverModel.id;
    } catch (error) {
      print('Error saving ${driverModel.toString()}: $error');
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
          return DriverModel.fromSnapshot(driverSnapshot) as T?;
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

      if (studentSnapshot.exists && studentSnapshot.value != null) {
        DataSnapshot firstChildSnapshot = studentSnapshot.children.first;
        return StudentModel.fromSnapshot(firstChildSnapshot);
      } else {
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

  Future<void> makeManualAttendance(
      String tripId, String studentId, int status) async {
    try {
      DatabaseReference tripRef = _rootRef
          .child('trips')
          .child(tripId)
          .child("studentTripStatus")
          .child(studentId);

      await tripRef.update({'status': status});

      print('Student with ID: $studentId in Trip $tripId');
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
      String reference, String id, String fieldName, dynamic value) async {
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

    final parentSnapshot =
        await parentsRef.orderByChild('isEnabled').equalTo(true).get();
    final parentList = parentSnapshot.children
        .map((child) => ParentModel.fromSnapshot(child))
        .toList();

    final studentSnapshot = await studentsRef.orderByChild('parentId').get();

    final List<StudentModel> students = studentSnapshot.children
        .map((studentChild) => StudentModel.fromSnapshot(studentChild))
        .where((student) =>
            parentList.any((parent) => parent.id == student.parentId))
        .toList();

    print("Disabled Data");
    students.forEach((student) {
      print('Student ID: ${student.id}, Parent ID: ${student.parentId}');
    });

    parentList.forEach((parent) {
      print('Parent ID: ${parent.id}, Status: ${parent.isEnabled}');
    });

    return students;
  }

  Future<List<StudentModel>> getStudentsParentsByStatus(bool status) async {
    print("I'm Called ");
    DatabaseReference studentsRef = _rootRef.child('students');
    DatabaseReference parentsRef = _rootRef.child('parents');

    final parentSnapshot =
        await parentsRef.orderByChild('isEnabled').equalTo(status).get();
    final parentList = parentSnapshot.children
        .map((child) => ParentModel.fromSnapshot(child))
        .toList();

    final studentSnapshot = await studentsRef.orderByChild('parentId').get();

    final List<StudentModel> students = studentSnapshot.children
        .map((studentChild) => StudentModel.fromSnapshot(studentChild))
        .where((student) =>
            parentList.any((parent) => parent.id == student.parentId))
        .toList();

    students.forEach((student) {
      print('Student ID: ${student.id}, Parent ID: ${student.parentId}');
    });

    return students;
  }

  Future<DriverLocationModel?> getDriverLocation() async {
    try {
      final snapshot = await _rootRef.child('tracking').child('driverId').get();
      return DriverLocationModel.fromSnapshot(snapshot);
    } catch (error) {
      print('Error getting driver: $error');
      return null;
    }
  }

  Future<String?> saveTrip(TripModel trip) async {
    String refName = "trips";
    String tripId = _rootRef.push().key ?? '';
    print("Is being save");
    print("Trip Id:${tripId}");
    DatabaseReference tripRef = _rootRef.child(refName).child(tripId);
    trip.id = tripId;
    tripRef.set(trip.toMap()).then((_) {
      print('Trip created successfully');
    }).catchError((error) {
      print('Failed to create trip: $error');
    });

    return tripId;
  }

  Future<List<StudentModel>> getStudentsOnBusWithStatus(String busId) async {
    print("Getting Students on Bus 1 with Status");

    // 1. Get Trip for Bus 1
    final tripSnapshot = await _rootRef
        .child('trips')
        .orderByChild('busId')
        .equalTo(busId)
        .get();

    if (tripSnapshot.children.isEmpty) {
      print("No Trip Found for Bus 1");
      return []; // Return empty list if no trip exists
    }

    final tripData = TripModel.fromSnapshot(tripSnapshot.children.first);

    // 2. Filter Students with Status based on tripData.studentTripStatus
    final studentsWithStatus1 = tripData.studentTripStatus?.entries
        .where((entry) => entry.value.status == 1)
        .map((entry) => entry.key) // Get student IDs
        .toList();

    // Check if any student has status 1
    if (studentsWithStatus1?.isEmpty ?? true) {
      print("No Students with Status 1 on Bus 1 Trip");
      return []; // Return empty list if no students with status 1
    }

    // 3. Get Student Details based on student IDs
    final studentList = <StudentModel>[];
    for (String studentId in studentsWithStatus1!) {
      final studentSnapshot =
          await DatabaseHelper.studentsRef.child(studentId).get();
      if (studentSnapshot.exists) {
        studentList.add(StudentModel.fromSnapshot(studentSnapshot));
      }
    }

    print("Students on Bus 1 with Status 1:");
    studentList.forEach((student) {
      print(
          'Student ID: ${student.id}, Status: ${tripData.studentTripStatus![student.id!.toString()]!.status}');
    });

    return studentList;
  }

  Future<TripModel?> getTripById(String tripId) async {
    try {
      DataSnapshot tripSnapshot =
          await _rootRef.child('trips').child(tripId).get();
      if (tripSnapshot.exists) {
        print("Found Trip");
        return TripModel.fromSnapshot(tripSnapshot);
      }

      if (tripSnapshot.children.isEmpty) {
        print("No Trip Found : $tripId");
        return null; // Return null if no trip exists
      }
    } catch (e) {
      print("Error fetching latest trip: $e");
      return null; // Return null in case of error
    }
    return null;
  }

  Future<TripModel?> listenTripById(
      String tripId, void Function(TripModel?) onDataChanged) async {
    try {
      DatabaseReference tripRef = _rootRef.child('trips').child(tripId);

      // Listen for data changes
      tripRef.onValue.listen((event) {
        if (event.snapshot.exists) {
          print("Found Trip");
          TripModel trip = TripModel.fromSnapshot(event.snapshot);
          onDataChanged(trip);
        } else {
          print("No Trip Found: $tripId");
          onDataChanged(null);
        }
      });
    } catch (e) {
      print("Error fetching latest trip: $e");
      onDataChanged(null);
    }
    return null;
  }

  Future<List<NotificationModel>> getNotifications() async {
    DataSnapshot dataSnapshot = await _rootRef.child("notifications").get();
    return dataSnapshot.children
        .map((child) => NotificationModel.fromSnapshot(child))
        .toList();
  }

  Future<List<NotificationModel>?> filterNotificationsByDate(
      List<NotificationModel> notifications) async {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyyMMdd'); // Format to compare dates

    List<NotificationModel> todayNotifications = [];
    List<NotificationModel> yesterdayNotifications = [];
    List<NotificationModel> otherDaysNotifications = [];

    notifications.forEach((notification) {
      // Parse the createdAt string back to DateTime
      DateTime createdAtDate = DateTime.parse(notification.createdAt ?? '');

      String createdAtDateString = formatter.format(createdAtDate);
      String todayDateString = formatter.format(now);
      String yesterdayDateString =
          formatter.format(now.subtract(Duration(days: 1)));

      if (createdAtDateString == todayDateString) {
        todayNotifications.add(notification);
      } else if (createdAtDateString == yesterdayDateString) {
        yesterdayNotifications.add(notification);
      } else {
        otherDaysNotifications.add(notification);
      }
    });

    Future<List<List<NotificationModel>>> filterNotificationsByDate(
        List<NotificationModel> notifications) async {
      DateTime now = DateTime.now();
      DateFormat formatter = DateFormat('yyyyMMdd'); // Format to compare dates

      List<NotificationModel> todayNotifications = [];
      List<NotificationModel> yesterdayNotifications = [];
      List<NotificationModel> otherDaysNotifications = [];

      notifications.forEach((notification) {
        // Parse the createdAt string back to DateTime
        DateTime createdAtDate = DateTime.parse(notification.createdAt ?? '');

        String createdAtDateString = formatter.format(createdAtDate);
        String todayDateString = formatter.format(now);
        String yesterdayDateString =
            formatter.format(now.subtract(Duration(days: 1)));

        if (createdAtDateString == todayDateString) {
          todayNotifications.add(notification);
        } else if (createdAtDateString == yesterdayDateString) {
          yesterdayNotifications.add(notification);
        } else {
          otherDaysNotifications.add(notification);
        }
      });

      return [
        todayNotifications,
        yesterdayNotifications,
        otherDaysNotifications
      ];
    }
    return null;
  }
}
