import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt bottomIndex = 0.obs;
  RxBool map = false.obs;
  final parentFName = TextEditingController();
  final parentLName = TextEditingController();
  final parentSN = TextEditingController();
  final parentNumber = TextEditingController();
  final parentPassword = TextEditingController();

  List studentStateNotification = [
    "الباص علئ وشك الوصول",
    "تم صعود الطالب للباص",
    "تم صعود الطالب للباص",
    "تم صعود الطالب للباص",
    "تم نزول الطالب من الباص"
  ];

  RxBool isInTheWay = false.obs;
  RxBool isClose = false.obs;
  RxBool isArrived = false.obs;
  RxBool notificationOn = true.obs;
}
