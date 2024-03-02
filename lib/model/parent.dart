class ParentModel {
  final String id;
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String nationalId;
  final bool isEnabled;
  final String chiledID;

  ParentModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.isEnabled,
    required this.chiledID,
  });

  // Convert model to a map for storing in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fName': fName,
      'lName': lName,
      'email': email,
      'phone': phone,
      'nationalId': nationalId,
      'isEnabled': isEnabled,
      'chieledID': chiledID,
    };
  }
}
