import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt bottomIndex = 0.obs;
  RxBool map = false.obs;
  // final paerntFName = TextEditingController();
  // final paerntLName = TextEditingController();
  // final paerntSN = TextEditingController();
  // final paerntNumber = TextEditingController();
  // final paerntPassword = TextEditingController();

  List studentStateNotification = [
    "الباص علئ وشك الوصول",
    "تم صعود الطالب للباص",
    "تم صعود الطالب للباص",
    "تم صعود الطالب للباص",
    "تم نزول الطالب من الباص"
  ];

  RxBool isInTheWay = false.obs;
  RxBool isClose = false.obs;
  RxBool isArraived = false.obs;
  RxBool notificationOn = true.obs;
}
