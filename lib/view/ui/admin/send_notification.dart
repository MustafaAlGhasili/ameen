import 'package:ameen/controller/admin_controller.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/admin/drivers/add_driver.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:ameen/view/ui/widget/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SendNotification extends StatelessWidget {
  const SendNotification({super.key});

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Get.put(AdminController());

    AdminController controller = Get.find();

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
                controller.sendNotification = value;
              },
              hPadding: width * 0.04,
              text: "ارسال الاشعار",
            ),
            SizedBox(
              height: height * 0.03,
            ),
            ButtonModel(
              onTap: () {
                //send notification
              },
              hMargin: width * 0.04,
              style: TextStyle(color: Colors.white, fontSize: width * 0.05),
              height: height * 0.055,
              backColor: PRIMARY_COLOR,
              rowMainAxisAlignment: MainAxisAlignment.center,
              content: 'ارسال',
            )
          ],
        ),
      ),
    );
  }
}


