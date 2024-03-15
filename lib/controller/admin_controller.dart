import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  String driverFName = '';
  String driverLName = '';
  String driverPhone = '';
  String driverNationalID = '';
  String driverBussNo = '';
  String driverLicence = '';

  final List<String> blood = ["B+", "A+", "B-", "A-"];
  RxList<String> buses = ['B1', 'C1', 'D1'].obs;
  RxString selectedBus = ''.obs;
  RxString driverBlood = ''.obs;
  RxString driverBDate = ''.obs;

  TextEditingController bDate= TextEditingController();

  void clearData() {
    driverFName = '';
    driverLName = '';
    driverPhone = '';
    driverBlood.value = '';
    driverBDate.value = '';
    driverNationalID = '';
    driverLicence = '';
    driverBussNo = '';
  }

}
