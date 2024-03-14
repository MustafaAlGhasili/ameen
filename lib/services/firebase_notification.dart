import 'package:ameen/model/token.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirebaseNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final String serverKey =
      'AAAARpR19j8:APA91bFn_EfZ04pOfz0n5jH6FfH5khXEzLvULxZLdmH5zIuOoj0qBNOc9mn4rlNpSA8ZdeTYdYzx9pNaosxjSX9XmplWmghaXwetl4MYQvGtit9SiZJPmnABFdSIIMUvLAaprsDEVl3R';

  Future<void> initialize() async {
    _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print("FCM token: $token");
    if (token != null) {
      TokenModel tokenModel = TokenModel(userId: "userId", token: token);
      await _databaseHelper.saveToken(tokenModel, "parents");
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });
  }

  Future<void> sendNotification(String title, String body, String token) async {
    final Map<String, dynamic> data = {
      'notification': {'title': title, 'body': body},
      'to': token,
    };

    final http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully!');
    } else {
      print('Failed to send notification: ${response.statusCode}');
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    _firebaseMessaging.subscribeToTopic(topic);
    print("subscribeToTopic: $topic");
  }

  Future<void> sendToTopic(String title, String body, String topic) async {
    final Map<String, dynamic> data = {
      'notification': {'title': title, 'body': body},
      'to': '/topics/$topic',
    };

    final http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully to topic: $topic');
    } else {
      print('Failed to send notification to topic: $topic, StatusCode: ${response.statusCode}');
    }
  }
}
