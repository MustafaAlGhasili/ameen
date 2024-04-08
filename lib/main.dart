import 'package:ameen/controller/admin_controller.dart';
import 'package:ameen/controller/driver_controller.dart';
import 'package:ameen/controller/notification_controller.dart';
import 'package:ameen/controller/sign_controller.dart';
import 'package:ameen/services/firebase_notification.dart';
import 'package:ameen/view/ui/admin/notification.dart';
import 'package:ameen/view/ui/admin/send_notification.dart';
import 'package:ameen/view/ui/sign/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/generated/l10n.dart';

import 'controller/camera_controller.dart';
import 'controller/home_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseNotification firebaseNotification = FirebaseNotification();
  await firebaseNotification.initialize();
//  await firebaseNotification.subscribeToTopic("parents");
  String token =
      "fE8Q0a7sQQ--yWhCLw-HqW:APA91bHeFJITcbqMiOM5qVQoLKx4uw-IQ-lR95UEbdHxyfi-iiBAUvim4uMRy7nExF91CveHfn20wYBG9xoV_nBlBEzPev_6SBdOll4vRTPbHyTiSLSr2R8VKmjJanZahssBMTDam3QK";
  //await firebaseNotification.sendNotification("title2", "body2", token);
  //await firebaseNotification.sendToTopic("title3", "body3", "parents");
  Get.lazyPut(() => AdminController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => DriverController());
  Get.lazyPut(() => NotificationController());
  Get.put(CamController());
  Get.put(SignController());

  runApp(GetMaterialApp(
    localizationsDelegates: const [
      S.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    useInheritedMediaQuery: true,
    theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 113, 65, 146)),
    home:  Notifications(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(height * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: const AssetImage("img/logo.png"),
            width: width * 0.8,
            fit: BoxFit.cover,
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const Start());
            },
            child: SizedBox(
              width: width * 0.65,
              height: height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: height * 0.027,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: width * 0.45,
                    child: Text(
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.rtl,
                      "ابدأ رحلتك مع أمين",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: height * 0.023,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
