import 'package:firebase_database/firebase_database.dart';

import '../utils/data_converter.dart';

class StudentModel implements ToMapConvertible {
  String id;
   String fName;
   String lName;
   String nationalId;
   String birthDate;
   String gender;
   String blood;
  final bool isEnabled;
  final String parentId;
   String address;
  final String schoolId;
  final String? busId; // Make it nullable
  final String? imgUrl; // Make it nullable
  final int grade;
  final double? latitude;
  final double? longitude;
   String email;
   String phone;

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
    this.busId, // Optional busId
    this.imgUrl,
    required this.email,
    required this.phone, 
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
      busId: data['busId'] as String?,
      imgUrl: data['imgUrl'] as String?,
      email: data['email'] as String,
      phone: data['phone'] as String,
    );
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as String,
      fName: map['fName'] as String,
      lName: map['lName'] as String,
      nationalId: map['nationalId'] as String,
      birthDate: map['birthDate'] as String,
      gender: map['gender'] as String,
      blood: map['blood'] as String,
      isEnabled: map['isEnabled'] as bool,
      parentId: map['parentId'] as String,
      schoolId: map['schoolId'] as String,
      grade: map['grade'] as int,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
      address: map['address'] as String,
      busId: map['busId'] as String?,// Use null-aware operator
      imgUrl: map['imgUrl'] as String?,// Use null-aware operator
      email: map['email'] as String,
      phone: map['phone'] as String,

    );
  }
  Map<String, dynamic> toJson() {
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
      'busId': busId,
      'imgUrl': imgUrl,
      'email': email,
      'phone': phone,
    };
  }

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
      'busId': busId,
      'imgUrl': imgUrl,
      'email': email,
      'phone': phone,
    };
  }
}
