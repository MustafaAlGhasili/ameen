import 'package:ameen/services/LocalStorageService.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:get/get.dart';

import '../model/trip.dart';

class DriverController extends GetxController {
  final _databaseHelper = DatabaseHelper();
  var currentTrip;

  @override
  void onInit() {
    super.onInit();
    print("Current Trip");
    print(currentTrip);
  }

  Future<bool> createTrip(int type) async {
    try {
      currentTrip = await LocalStorageService.getTrip();
      if (currentTrip != null &&
          isSameDay(currentTrip.createdAt!, DateTime.now()) &&
          currentTrip.type == type) {
        print("Trip already created today. Ignoring new trip creation.");
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
      await LocalStorageService.saveTrip(trip);
      return true;
    } catch (e) {
      print("Error creating trip: $e");
      return false;
    }
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
