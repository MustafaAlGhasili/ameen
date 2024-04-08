import 'package:firebase_database/firebase_database.dart';
import '../utils/data_converter.dart';

class NotificationModel implements ToMapConvertible {
  String id;
  final String? title;
  final String? description;
  final String? parentId;
  final String? createdAt;

  NotificationModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.parentId,
    required this.createdAt,
  });

  factory NotificationModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return NotificationModel(
      id: data['id'] as String,
      title: data['title'] as String?,
      description: data['description'] as String?,
      parentId: data['parentId'] as String?,
      createdAt: data['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'parentId': parentId,
      'createdAt': createdAt,
    };
  }
}
