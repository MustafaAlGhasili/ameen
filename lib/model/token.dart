import 'package:firebase_database/firebase_database.dart';
import '../utils/data_converter.dart';

class TokenModel implements ToMapConvertible {
  final String? userId;
  final String? token;

  TokenModel({
    required this.userId,
    required this.token,
  });

  factory TokenModel.fromSnapshot(DataSnapshot snapshot) {
    final Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
    return TokenModel(
      userId: data['userId'] as String?,
      token: data['token'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'token': token,
    };
  }
}
