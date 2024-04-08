import 'package:ameen/model/notification.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  late DatabaseHelper _databaseHelper;
  RxBool _isLoading = false.obs; // Add this variable
  RxBool get isLoading => _isLoading;
  String sendNotification='';

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
}
