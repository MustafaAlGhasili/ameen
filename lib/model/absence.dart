import 'package:firebase_database/firebase_database.dart';

class AbsenceModel {
  String studentId;
  String createdAt;

  AbsenceModel({
    required this.studentId,
    required this.createdAt,
  });

  factory AbsenceModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    return AbsenceModel(
      studentId: data['studentId'] as String,
      createdAt: data['createdAt'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'createdAt': createdAt,
    };
  }
}
