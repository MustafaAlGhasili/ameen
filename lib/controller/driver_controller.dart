import 'dart:async';

import 'package:ameen/services/LocalStorageService.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:get/get.dart';

import '../model/student.dart';
import '../model/trip.dart';
import '../view/ui/driver/student_trip.dart';

class DriverController extends GetxController {

  RxBool isOneEmpty = false.obs;
  RxBool isTwoEmpty = false.obs;

  final _databaseHelper = DatabaseHelper();
  var currentTrip;
  late String? tripId;
  @override
  void onInit() async {
    super.onInit();
    print("Current Trip");
    currentTrip = await LocalStorageService.getTrip();
    tripId = await currentTrip!.id;
  }

  Future<bool> createTrip(int type) async {
    try {
      currentTrip = await LocalStorageService.getTrip();
      if (currentTrip != null &&
          isSameDay(currentTrip.createdAt!, DateTime.now()) &&
          currentTrip.type == type) {
        print("Trip already created today. Ignoring new trip creation.");
        Get.to(() => Trip(
              tripType: type,
            ));
        return false;
      }

      final driver = await LocalStorageService.getDriver();
      if (driver == null) {
        throw Exception("Driver not found");
      }

      final students = await _databaseHelper.getStudentsByBusId(driver.busId);
      if (students.isEmpty) {
        throw Exception(
            "No students found for the driver's bus: ${driver.busId}");
      }

      Map<String, StudentTripStatus> studentTripStatus = {};
      students.forEach((student) {
        studentTripStatus[student.id] =
            StudentTripStatus(id: student.id, status: 0);
        print("Student: ${student.id}");
      });

      TripModel trip = TripModel(
        id: '',
        type: type,
        driverId: driver.id,
        busId: driver.busId,
        createdAt: DateTime.now(),
        studentTripStatus: studentTripStatus,
      );

      await _databaseHelper.saveTrip(trip);
      tripId = trip.id!;
      await LocalStorageService.saveTrip(trip);
      Get.to(() => const Trip(
            tripType: 1,
          ));
      return true;
    } catch (e) {
      print("Error creating trip: $e");
      return false;
    }
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  Future<TripModel?> getTrip(String id) async {
    final result = await _databaseHelper.getTripById(id);
    tripId = result?.id;
    print(result);
    return result;
  }

  Future<TripModel?> testing(String id) async {
    Completer<TripModel?> completer = Completer<TripModel?>();

    bool completed = false; // Flag to track if the completer has been completed

    _databaseHelper.listenTripById(id, (trip) {
      if (!completed) {
        if (trip != null) {
          print("Trip ID: ${trip.id}");
          completer.complete(trip);
        } else {
          print("No trip found.");
          completer.complete(null);
        }
        completed = true; // Set the flag to true after completing the completer
      }
    });

    return completer.future;
  }

  Future<List<StudentModel>> getBusStudentsWithStatus(int status) async {
    try {
      final driver = await LocalStorageService.getDriver();
      if (driver == null) {
        throw Exception("Driver not found");
      }
      final students = await _databaseHelper.getStudentsByBusId(driver.busId);
      List<StudentModel> filteredStudents = [];

      if (students.isEmpty) {
        throw Exception("No students found for the driver's bus");
      }
      final dbTrip = await _databaseHelper.getTripById(currentTrip.id);
      print(dbTrip);
      final studentTripStatus = dbTrip?.studentTripStatus;
      if (studentTripStatus != null) {
        print("Start Filtering");
        students.forEach((student) {
          if (studentTripStatus[student.id]?.status == status) {
            print("Found Student Status");
            filteredStudents.add(student);
          }
        });
        print("Students with status $status:");
        filteredStudents.forEach((student) {
          print('Student ID Is: ${student.id}, Name: ${student.fName}');
        });
      }

      return filteredStudents;
    } catch (e) {
      print("Error fetching bus students with status: $e");
      return []; // Return an empty list in case of error
    }
  }
}
