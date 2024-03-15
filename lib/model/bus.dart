class BusModel {
  final String id;
  final String schoolId;

  const BusModel({
    required this.id,
    required this.schoolId,
  });

  // Create a BusModel from a Map (for reading from Firebase)
  factory BusModel.fromMap(Map<String, dynamic> map) {
    return BusModel(
      id: map['id'] as String,
      schoolId: map['schoolId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'schoolId': schoolId,
    };
  }
}
