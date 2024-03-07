class DriverLocationModel {
  final String driverId;
  final double latitude;
  final double longitude;
  final String timestamp;

  const DriverLocationModel({
    required this.driverId,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  // Create a DriverLocationModel from a Map (for reading from Firebase)
  factory DriverLocationModel.fromMap(Map<String, dynamic> map) {
    return DriverLocationModel(
      driverId: map['driverId'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      timestamp: map['timestamp'] as String,
    );
  }

  // Convert DriverLocationModel to a Map (for writing to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }
}
