import 'package:Amin/model/notification.dart';
import 'package:Amin/utils/DatabaseHelper.dart';
import 'package:get/get.dart';

import '../services/LocalStorageService.dart';

class NotificationController extends GetxController {
  late DatabaseHelper _databaseHelper;
  RxBool _isLoading = false.obs; // Add this variable
  RxBool get isLoading => _isLoading;
  String sendNotification = '';

  @override
  void onInit() {
    _databaseHelper = DatabaseHelper();
    super.onInit();
  }

  Future<bool> createAdminNotification(String content) async {
    _isLoading(true);

    try {
      final notification = NotificationModel(
        title: content,
        description: content,
        parentId: "none",
        type: 2,
        createdAt: DateTime.now().toIso8601String(),
      );
      String? notificationId =
          await _databaseHelper.save(notification, "notifications");
      print("Notification Created with Id:$notificationId");
      return true;
    } catch (e) {
      // Handle other exceptions
      print('Error sending password reset email: $e');
      _isLoading(false);
      return false;
    }
  }

  Future<List<NotificationModel>> getParentNotifications() async {
    try {
      final parent = await LocalStorageService.getParent();
      if (parent == null) {
        throw Exception("Parent not found");
      }
      final notifications =
          await _databaseHelper.getNotificationsByParentId(parent.id);

      print("Notifications found$notifications");
      return notifications;
    } catch (e) {
      print("Error fetching Notifications: $e");
      return []; // Return an empty list in case of error
    }
  }
}
