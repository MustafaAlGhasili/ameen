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

  // Convert model to a map for storing in the database
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
}
