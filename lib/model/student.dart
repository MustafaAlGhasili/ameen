import 'package:firebase_database/firebase_database.dart';

import '../utils/data_converter.dart';

class StudentModel implements ToMapConvertible {
  String id;
  final String fName;
  final String lName;
  final String nationalId;
  final String birthDate;
  final String gender;
  final String blood;
  final bool isEnabled;
  final String parentId;
  final String address;
  final String schoolId;
  final int grade;
  final double? latitude;
  final double? longitude;

  StudentModel({
    this.id = "",
    required this.fName,
    required this.lName,
    required this.nationalId,
    required this.birthDate,
    required this.gender,
    required this.blood,
    required this.isEnabled,
    required this.parentId,
    required this.schoolId,
    required this.grade,
    required this.longitude,
    required this.latitude,
    required this.address,
  });

  factory StudentModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return StudentModel(
      id: data['id'] as String,
      fName: data['fName'] as String,
      lName: data['lName'] as String,
      nationalId: data['nationalId'] as String,
      birthDate: data['birthDate'] as String,
      gender: data['gender'] as String,
      blood: data['blood'] as String,
      isEnabled: data['isEnabled'] as bool,
      parentId: data['parentId'] as String,
      schoolId: data['schoolId'] as String,
      grade: data['grade'] as int,
      longitude: data['longitude'] as double,
      latitude: data['latitude'] as double,
      address: data['address'] as String,
    );
  }

  // Convert model to a map for storing in the database
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fName': fName,
      'lName': lName,
      'nationalId': nationalId,
      'birthDate': birthDate,
      'gender': gender,
      'blood': blood,
      'isEnabled': isEnabled,
      'parentId': parentId,
      'schoolId': schoolId,
      'grade': grade,
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
    };
  }
}
