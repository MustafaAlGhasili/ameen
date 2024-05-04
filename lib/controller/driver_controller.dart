import 'dart:async';

import 'package:ameen/model/absence.dart';
import 'package:ameen/services/LocalStorageService.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../model/student.dart';
import '../model/trip.dart';
import '../view/ui/driver/student_trip.dart';

class DriverController extends GetxController {
  RxBool isOneEmpty = false.obs;
  RxBool isTwoEmpty = false.obs;
  late List<AbsenceModel> absenceList;
  late List<String> absenceIdsList = [];
  final _databaseHelper = DatabaseHelper();
  bool studentsEmpty  = false;
  bool studentsWaitingEmpty  = false;
  bool endWorkUpdate = false;

  late var currentTrip;
  late String? tripId;
  bool isWorking = false;

  @override
  void onInit() async {
    super.onInit();
    print("Current Trip");
    currentTrip = await LocalStorageService.getTrip();
    tripId = await currentTrip!.id;

    await getTodayAbsence();
  }

  Future<bool> createTrip(int type) async {
    try {
      currentTrip = await LocalStorageService.getTrip();
      Get.dialog(const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ));
      await Future.delayed(const Duration(milliseconds: 200));

      print("Checking current trip");
      isWorking = true;
      if (currentTrip != null &&
          isSameDay(currentTrip.createdAt!, DateTime.now()) &&
          currentTrip.type == type) {
        print("Trip already created today. Ignoring new trip creation.");
        Get.off(() => Trip(
              tripType: type,
            ));
        return false;
      }
      print("Getting Driver");
      final driver = await LocalStorageService.getDriver();
      if (driver == null) {
        throw Exception("Driver not found");
      }

      final students = await _databaseHelper.getStudentsByBusId(driver.busId);
      if (students.isEmpty) {
        Get.showSnackbar(
          GetSnackBar(
            borderRadius: 20,
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * 0.045, vertical: Get.height * 0.015),
            icon: Icon(
              IconlyLight.info_circle,
              color: Colors.white,
              size: Get.width * 0.065,
            ),
            title: "خطأ",
            message: "لايوجد طلاب حاليا",
            duration: const Duration(seconds: 3),
            animationDuration: const Duration(milliseconds: 600),
          ),
        );
        throw Exception(
            "No students found for the driver's bus: ${driver.busId}");
      }
      if (students.length == 0) {
        print("No Students for this bus");
      }
      print("Students List$students");
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
      currentTrip = trip;
      Get.to(() => Trip(
            tripType: type,
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

  Future<void> getTodayAbsence() async {
    absenceList = await _databaseHelper.getTodayAbsences();
    absenceList.forEach((absence) {
      absenceIdsList.add(absence.studentId);
    });

    print("Absence List$absenceIdsList");
  }

  Future<void> refreshTodayAbsence(List<AbsenceModel> absenceList) async {
    print("Refreshing Absence");
    if (absenceIdsList.length > 0) {
      absenceIdsList.clear();
      absenceList.forEach((absence) {
        absenceIdsList.add(absence.studentId);
      });
      print("Absence List$absenceIdsList");
      _databaseHelper.updateField("trips", currentTrip.id, "status", 1);
      _databaseHelper.updateField("trips", currentTrip.id, "status", 0);
    }
  }

  Future<List<StudentModel>> getBusStudentsWithStatus(int status) async {
    try {
      final driver = await LocalStorageService.getDriver();
      if (driver == null) {
        throw Exception("Driver not found");
      }
      final students = await _databaseHelper.getStudentsByBusId(driver.busId);
      List<StudentModel> filteredStudents = [];
      print("Started getting students for the bus");
      if (students.isEmpty) {
        throw Exception("No students found for the driver's bus");
      }
      print("Started getting trip for the bus");
      final dbTrip = await _databaseHelper.getTripById(currentTrip.id);
      final studentTripStatus = dbTrip?.studentTripStatus;
      print("dbTrip/n:${dbTrip?.id}");
      print("studentTripStatus/n:$studentTripStatus");
      if (studentTripStatus != null) {
        print("Start Filtering ${studentTripStatus.length} Students");
        List<StudentModel> nonAbsentStudents = students
            .where((student) => !absenceIdsList.contains(student.id))
            .toList();

        nonAbsentStudents.forEach((student) {
          print(
              "Checking  ${student.fName} Status Which is ${studentTripStatus[student.id]?.status} ");

          if (studentTripStatus[student.id]?.status == status) {
            print("Found Student Status");
            filteredStudents.add(student);
          }
        });
        print("Students with status $status:");
        filteredStudents.forEach((student) {
          print('Student ID Is: ${student.id}, Name: ${student.fName}');
        });
      } else {
        print("students for the bus are null");
      }

      return filteredStudents;
    } catch (e) {
      print("Error fetching bus students with status: $e");
      return []; // Return an empty list in case of error
    }
  }
}
