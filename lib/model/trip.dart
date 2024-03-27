import 'package:firebase_database/firebase_database.dart';
import '../utils/data_converter.dart';

class TripModel implements ToMapConvertible {
  late  String? id;
  final int? type;
  final String? driverId;
  final String? busId;
  final DateTime? createdAt;
  final Map<String, StudentTripStatus>? studentTripStatus;

  TripModel({
    required this.id,
    required this.type,
    required this.driverId,
    required this.busId,
    required this.createdAt,
    required this.studentTripStatus,
  });

  factory TripModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return TripModel(
      id: data['id'] as String?,
      type: data['type'] as int?,
      driverId: data['driverId'] as String?,
      busId: data['busId'] as String?,
      createdAt: DateTime.parse(data['createdAt'] as String),
      studentTripStatus: (data['studentTripStatus'] as Map<dynamic, dynamic>?)?.map(
            (key, value) => MapEntry(key.toString(), StudentTripStatus.fromMap(value as Map<String, dynamic>)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'driverId': driverId,
      'busId': busId,
      'createdAt': createdAt?.toIso8601String(),
      'studentTripStatus': studentTripStatus?.map((key, value) => MapEntry(key, value.toMap())),
    };
  }
}

class StudentTripStatus {
  final String id; // Student ID
  final int status; // Status of the student

  StudentTripStatus({
    required this.id,
    required this.status,
  });

  factory StudentTripStatus.fromMap(Map<String, dynamic> map) {
    return StudentTripStatus(
      id: map['id'] as String,
      status: map['status'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
    };
  }
}
