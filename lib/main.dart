import 'dart:ui';
import 'package:Amin/controller/driver_controller.dart';
import 'package:Amin/services/firebase_notification.dart';
import 'package:Amin/view/ui/offlin_page.dart';
import 'package:Amin/view/ui/sign/splash_screen.dart';
import 'package:Amin/view/ui/sign/start.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/generated/l10n.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseNotification firebaseNotification = FirebaseNotification();
  await firebaseNotification.initialize();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  String token =
      "fE8Q0a7sQQ--yWhCLw-HqW:APA91bHeFJITcbqMiOM5qVQoLKx4uw-IQ-lR95UEbdHxyfi-iiBAUvim4uMRy7nExF91CveHfn20wYBG9xoV_nBlBEzPev_6SBdOll4vRTPbHyTiSLSr2R8VKmjJanZahssBMTDam3QK";
  //await firebaseNotification.sendNotification("title2", "body2", token);
  //await firebaseNotification.sendToTopic("title3", "body3", "parents");
  Get.put(DriverController());
  Connectivity connectivity = Connectivity();
  runApp(
    GetMaterialApp(
      title: "Amin",
      useInheritedMediaQuery: true,
      locale: const Locale.fromSubtags(countryCode: "ar"),
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 113, 65, 146),
      ),
      home: StreamBuilder(
        stream: connectivity.onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.data == ConnectivityResult.none) {
            return const OfflinePage();
          } else {
            return const SplashScreen();
          }
        },
      ),
    ),
  );
}

class First extends StatelessWidget {
  const First({super.key});

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
