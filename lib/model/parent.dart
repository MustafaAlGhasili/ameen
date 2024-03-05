import 'package:firebase_database/firebase_database.dart';

import '../utils/data_converter.dart';

class ParentModel implements ToMapConvertible {
  final String id;
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String nationalId;
  final bool isEnabled;

  ParentModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.isEnabled,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': fName,
      'lastName': lName,
      'email': email,
      'phone': phone,
      'nationalId': nationalId,
      'isEnabled': isEnabled,
    };
  }

  factory ParentModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return ParentModel(
      id: data['id'] as String,
      fName: data['firstName'] as String,
      lName: data['lastName'] as String,
      email: data['email'] as String,
      phone: data['phone'] as String,
      nationalId: data['nationalId'] as String,
      isEnabled: data['isEnabled'] as bool,
    );
  }
}
