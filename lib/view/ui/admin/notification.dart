import 'package:ameen/view/ui/admin/send_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                icon: const Icon(Icons.notification_add_sharp))
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
          margin: EdgeInsets.only(right: width * 0.05, top: height * 0.06),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("اليوم",
                    style: TextStyle(fontSize: width * 0.05),
                    textAlign: TextAlign.end),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 10),
                height: height * 0.06,
                width: width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: const Text("اشعار بوجود حالة طوارئ"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
