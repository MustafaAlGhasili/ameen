import 'package:firebase_database/firebase_database.dart';
import '../utils/data_converter.dart';

class DriverModel implements ToMapConvertible {
  final String id;
  final String fName;
  final String lName;
  final String phone;
  final String email; // New field for email
  final String nationalId;
  final bool isEnabled;
  final String driverBDate;
  final String blood;
  final String driverLicence;
  final String busId;
  final String photo;

  DriverModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.email, // New field for email
    required this.nationalId,
    required this.isEnabled,
    required this.driverBDate,
    required this.blood,
    required this.driverLicence,
    required this.busId,
    required this.photo,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': fName,
      'lastName': lName,
      'phone': phone,
      'email': email, // Include email in the map
      'nationalId': nationalId,
      'isEnabled': isEnabled,
      'driverBDate': driverBDate,
      'blood': blood,
      'driverLicence': driverLicence,
      'busId': busId,
      'photo': photo,
    };
  }

  factory DriverModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return DriverModel(
      id: data['id'] as String,
      fName: data['firstName'] as String,
      lName: data['lastName'] as String,
      phone: data['phone'] as String,
      email: data['email'] as String,
      // Get email from snapshot
      nationalId: data['nationalId'] as String,
      isEnabled: data['isEnabled'] as bool,
      driverBDate: data['driverBDate'] as String,
      blood: data['blood'] as String,
      driverLicence: data['driverLicence'] as String,
      busId: data['busId'] as String,
      photo: data['photo'] as String,
    );
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      id: map['id'] as String,
      fName: map['firstName'] as String,
      lName: map['lastName'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      // Get email from map
      nationalId: map['nationalId'] as String,
      isEnabled: map['isEnabled'] as bool,
      driverBDate: map['driverBDate'] as String,
      blood: map['blood'] as String,
      driverLicence: map['driverLicence'] as String,
      busId: map['busId'] as String,
      photo: map['photo'] as String,
    );
  }
}
