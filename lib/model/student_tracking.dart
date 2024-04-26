import 'package:firebase_database/firebase_database.dart';

class StudentTrackingModel {
  final int status;
  final int tripType;
  final String studentId;

  const StudentTrackingModel({
    required this.status,
    required this.studentId,
    required this.tripType,
  });

  factory StudentTrackingModel.fromMap(Map<String, dynamic> map) {
    return StudentTrackingModel(
      status: map['status'] as int,
      tripType: map['tripType'] as int,
      studentId: map['studentId'] as String,
    );
  }

  factory StudentTrackingModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return StudentTrackingModel(
      status: data['status'] as int,
      tripType: data['tripType'] as int,
      studentId: data['studentId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'studentId': studentId,
      'tripType': tripType,
    };
  }
}
