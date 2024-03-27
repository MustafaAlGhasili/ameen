import 'package:firebase_database/firebase_database.dart';

class DriverLocationModel {
  final String driverId;
  final String busId;
  final double latitude;
  final double longitude;
  final String timestamp;

  const DriverLocationModel({
    required this.driverId,
    required this.busId,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  // Create a DriverLocationModel from a Map (for reading from Firebase)
  factory DriverLocationModel.fromMap(Map<String, dynamic> map) {
    return DriverLocationModel(
      driverId: map['driverId'] as String,
      busId: map['busId'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      timestamp: map['timestamp'] as String,
    );
  }

  factory DriverLocationModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return DriverLocationModel(
      driverId: data['driverId'] as String,
      busId: data['busId'] as String,
      latitude: data['latitude'] as double,
      longitude: data['longitude'] as double,
      timestamp: data['timestamp'] as String,
    );
  }

  // Convert DriverLocationModel to a Map (for writing to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'busId': busId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }
}
