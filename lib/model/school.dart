import 'package:firebase_database/firebase_database.dart';

import '../utils/data_converter.dart';

class SchoolModel implements ToMapConvertible {
  final String? id;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;

  SchoolModel({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory SchoolModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return SchoolModel(
      id: data['id'] as String?,
      name: data['name'] as String,
      address: data['address'] as String,
      latitude: data['latitude'] as double,
      longitude: data['longitude'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
