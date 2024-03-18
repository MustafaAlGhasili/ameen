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

  Future<StudentModel?> studentShared() async{

    final student = StudentModel(
      id: '123',
      imgUrl: '555',
      busId: '858',
      fName: controller.studentFName.text,
      lName: controller.studentLName.text,
      nationalId: controller.studentNationalId.text,
      birthDate: controller.studentBDate.text,
      gender: controller.genderValue.value,
      blood: controller.bloodValue.value,
      isEnabled: false,
      parentId: '55',
      schoolId: '55',
      grade: 55,
      longitude: 12,
      latitude: 13,
      address: '55',
      email: controller.studentEmail.text
    );
    await LocalStorageService.saveStudent(student);
    final getStudent = await  LocalStorageService.getStudent();
    print("getStudent $getStudent");
    return getStudent;
  }


}
