import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Amin/controller/notification_controller.dart';
import 'package:Amin/utils/constants.dart';
import 'package:Amin/view/ui/widget/text_field.dart';

class SendNotification extends StatelessWidget {
  const SendNotification({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isLoading = false;
    Get.put(NotificationController());
    NotificationController controller = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ارسال الإشعارات"),
          backgroundColor: PRIMARY_COLOR,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            TextFieldModel(
              maxLines: 3,
              onChanged: (value) {
                // Assign the value to sendNotification variable
                controller.sendNotification = value;
              },
              hPadding: width * 0.04,
              text: "ارسال الاشعار",
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Obx(() {
              return ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null // Disable the button while loading
                    : () async {
                  // Set isLoading to true before sending the notification
                  controller.isLoading(true);
                  // Send notification
                  bool success = await controller.createAdminNotification(controller.sendNotification);
                  if (success) {
                    // Handle success scenario
                  } else {
                    // Handle failure scenario
                  }
                  // Set isLoading back to false after sending the notification
                  controller.isLoading(false);
                },
                style: ElevatedButton.styleFrom(
                  primary: PRIMARY_COLOR,
                  padding: const  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                child: controller.isLoading.value
                    ? const  SizedBox( // Show loading indicator when loading
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
                    : Text( // Show button text when not loading
                  'إرسال',
                  style: TextStyle(fontSize: width * 0.05,color: Colors.white),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
