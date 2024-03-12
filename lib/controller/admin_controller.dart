import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final TextEditingController driverBDate = TextEditingController();

  final List<String> blood = ["B+", "A+", "B-", "A-"];
  RxList<String> buses = ['B1', 'C1', 'D1'].obs;
  RxString selectedBus = ''.obs;


  RxString driverBlood = ''.obs;
}
