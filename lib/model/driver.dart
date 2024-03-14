import 'package:firebase_database/firebase_database.dart';

import '../utils/data_converter.dart';

class DriverModel implements ToMapConvertible {
  late String id;
  final String fName;
  final String lName;
  final String phone;
  final String nationalId;
  final bool isEnabled;
  final String driverBDate;
  final String blood;
  final String driverLicence;
  final String busNumber;

  DriverModel({
     this.id="",
    required this.fName,
    required this.lName,
    required this.phone,
    required this.nationalId,
    required this.isEnabled,
    required this.driverBDate,
    required this.blood,
    required this.driverLicence,
    required this.busNumber,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': fName,
      'lastName': lName,
      'phone': phone,
      'nationalId': nationalId,
      'isEnabled': isEnabled,
      'driverBDate': driverBDate,
      'blood': blood,
      'driverLicence': driverLicence,
      'busNumber': busNumber,
    };
  }

  factory DriverModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return DriverModel(
      id: data['id'] as String,
      fName: data['firstName'] as String,
      lName: data['lastName'] as String,
      phone: data['phone'] as String,
      nationalId: data['nationalId'] as String,
      isEnabled: data['isEnabled'] as bool,
      driverBDate: data['driverBDate'] as String,
      blood: data['blood'] as String,
      driverLicence: data['driverLicence'] as String,
      busNumber: data['busNumber'] as String,
    );
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      id: map['id'] as String,
      fName: map['firstName'] as String,
      lName: map['lastName'] as String,
      phone: map['phone'] as String,
      nationalId: map['nationalId'] as String,
      isEnabled: map['isEnabled'] as bool,
      driverBDate: map['driverBDate'] as String,
      blood: map['blood'] as String,
      driverLicence: map['driverLicence'] as String,
      busNumber: map['busNumber'] as String,
    );
  }
}
