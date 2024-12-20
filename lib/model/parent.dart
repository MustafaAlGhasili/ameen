import 'package:firebase_database/firebase_database.dart';

import '../utils/data_converter.dart';

class ParentModel implements ToMapConvertible {
  final String id;
   String fName;
   String lName;
   String email;
   String phone;
   String nationalId;
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

  factory ParentModel.fromMap(Map<String, dynamic> map) {
    return ParentModel(
      id: map['id'] as String,
      fName: map['firstName'] as String,
      lName: map['lastName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      nationalId: map['nationalId'] as String,
      isEnabled: map['isEnabled'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
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

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      id: json['id'] as String,
      fName: json['firstName'] as String,
      lName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      nationalId: json['nationalId'] as String,
      isEnabled: json['isEnabled'] as bool,
    );
  }
}
