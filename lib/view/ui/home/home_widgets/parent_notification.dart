import 'package:ameen/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/notification_controller.dart';
import '../../widget/parent_notification_card.dart';

class ParentNotifications extends StatelessWidget {
  const ParentNotifications({Key? key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());
    NotificationController controller = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const SizedBox(),
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text("الإشعارات"),
        ),
        body: FutureBuilder<List<NotificationModel>>(
          future: controller.getParentNotifications(),
          // Assuming this function returns a List<StudentModel>
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final List<NotificationModel> notifications = snapshot.data!;
              if (notifications.isEmpty) {
                return const Center(
                  child: Text('No notifications'),
                );
              } else {
                notifications
                    .sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

                List<Widget> notificationWidgets = [];

                DateTime now = DateTime.now();
                DateTime yesterday = now.subtract(Duration(days: 1));

                List<NotificationModel> todayNotifications = [];
                List<NotificationModel> yesterdayNotifications = [];
                List<NotificationModel> otherNotifications = [];

                for (var notification in notifications) {
                  DateTime notificationDate =
                      DateTime.parse(notification.createdAt!);

                  if (notificationDate.year == now.year &&
                      notificationDate.month == now.month &&
                      notificationDate.day == now.day) {
                    todayNotifications.add(notification);
                  } else if (notificationDate.year == yesterday.year &&
                      notificationDate.month == yesterday.month &&
                      notificationDate.day == yesterday.day) {
                    yesterdayNotifications.add(notification);
                  } else {
                    otherNotifications.add(notification);
                  }
                }

                if (todayNotifications.isNotEmpty) {
                  notificationWidgets.add(_buildSection(
                    context,
                    "اليوم",
                    todayNotifications,
                  ));
                }

                if (yesterdayNotifications.isNotEmpty) {
                  notificationWidgets.add(_buildSection(
                    context,
                    "أمس",
                    yesterdayNotifications,
                  ));
                }

                if (otherNotifications.isNotEmpty) {
                  notificationWidgets.add(_buildSection(
                    context,
                    "الأيام السابقة",
                    otherNotifications,
                  ));
                }

                return ListView(
                  children: notificationWidgets,
                );
              }
            } else {
              return Center(
                child: Text("No data found"),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title,
      List<NotificationModel> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            NotificationModel notification = notifications[index];
            return ParentNotificationCard(
              notification: notification,
            );
          },
        ),
      ],
    );
  }
}
