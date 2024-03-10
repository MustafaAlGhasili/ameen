import 'package:firebase_database/firebase_database.dart';
import '../utils/data_converter.dart';

class AdminModel implements ToMapConvertible {
  final String? id;
  final String? name;
  final String? email;

  AdminModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory AdminModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return AdminModel(
      id: data['id'] as String?,
      name: data['name'] as String,
      email: data['email'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
