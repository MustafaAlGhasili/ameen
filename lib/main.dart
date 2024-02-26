import 'package:ameen/controller/sign_controller.dart';
// import 'package:ameen/test.dart';
// import 'package:ameen/view/ui/home/home.dart';
import 'package:ameen/view/ui/sign/start.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:device_preview/device_preview.dart';
import 'controller/home_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(SignController());
  Get.put(HomeController());


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      // DevicePreview(
      // enabled: !kReleaseMode,
      // builder: (context) =>
      GetMaterialApp(
    useInheritedMediaQuery: true,
    // locale: DevicePreview.locale(context),
    theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 113, 65, 146)),
    home: const MyApp(),
    // )
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
