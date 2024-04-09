import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase database
import 'package:ameen/view/ui/admin/send_notification.dart';
import 'package:ameen/view/ui/widget/notification_card.dart'; // Import the NotificationCard widget
import 'package:ameen/model/notification.dart'; // Import the NotificationModel

class AdminNotifications extends StatelessWidget {
  const AdminNotifications({Key? key});


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    DatabaseReference notificationsRef =
    FirebaseDatabase.instance.ref().child('notifications');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const SendNotification());
              },
              icon: const Icon(Icons.notification_add_sharp),
            ),
          ],
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          title: Text(
            "الإشعارات",
            style: TextStyle(
              fontSize: width * 0.06,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: FirebaseAnimatedList(
            query: notificationsRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              NotificationModel notification =
              NotificationModel.fromSnapshot(snapshot);
              return NotificationCard(notification: notification,

              );
            },
          ),
        ),
      ),
    );
  }
}
