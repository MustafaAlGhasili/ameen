class StudentModel {
  final String id;
  final String fName;
  final String lName;
  // final String email;
  final String nationalId;
  final String birthDate;
  final String gender;
  final String blood;
  final bool isEnabled;
  final String parent;

  StudentModel(
      {required this.id,
      required this.fName,
      required this.lName,
      required this.nationalId,
      required this.birthDate,
      required this.gender,
      required this.blood,
      required this.isEnabled,
      required this.parent});

  // Convert model to a map for storing in the database
  Map<String, dynamic> toMap() {
    return {
      
        'id': id,
        'fName': fName,
        'lName': lName,
        'nationalId': nationalId,
        'birtDate': birthDate,
        'gender': gender,
        'blood': blood,
        'isEnabled': isEnabled,
        'parentID': parent,
      
    };
  }
}
