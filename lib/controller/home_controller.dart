import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/parent.dart';
import '../services/LocalStorageService.dart';

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

  Future<void> testSharedPref() async {
    final parent = ParentModel(
      id: '1',
      fName: 'John',
      lName: 'Doe',
      email: 'john.doe@example.com',
      phone: '1234567890',
      nationalId: '123456789',
      isEnabled: true,
    );
    await LocalStorageService.saveParent(parent);

    final retrievedParent = await LocalStorageService.getParent();
    print(retrievedParent);
    print(retrievedParent?.email);
  }

}