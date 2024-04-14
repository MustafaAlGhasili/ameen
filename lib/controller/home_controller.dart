import 'package:ameen/controller/sign_controller.dart';
import 'package:ameen/model/student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/parent.dart';
import '../services/LocalStorageService.dart';

class HomeController extends GetxController {
  SignController controller = Get.find<SignController>();

  RxInt bottomIndex = 0.obs;
  RxBool map = false.obs;

  // final parentFName = TextEditingController();
  // final parentLName = TextEditingController();
  // final parentSN = TextEditingController();
  // final parentNumber = TextEditingController();
  // final parentPassword = TextEditingController();


  RxBool isInTheWay = false.obs;
  RxBool isClose = false.obs;
  RxBool isArrived = false.obs;
  RxBool notificationOn = true.obs;

  Future<ParentModel?> parentShared() async {
    final parent = ParentModel(
      id: '123',
      fName: controller.parentFName.text,
      lName: controller.parentLName.text,
      email: controller.parentEmail.text,
      phone: controller.parentPhone.text,
      nationalId: controller.parentNationalId.text,
      isEnabled: true,
    );
    await LocalStorageService.saveParent(parent);

    final getParent = await LocalStorageService.getParent();
    print(getParent);
    print(getParent?.email);
    return getParent;

  }



}
