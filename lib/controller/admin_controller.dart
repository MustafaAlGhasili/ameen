import 'package:ameen/services/auth_service/AuthService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/driver.dart';
import '../utils/DatabaseHelper.dart';

class AdminController extends GetxController {
  String driverFName = '';
  String driverLName = '';
  String driverEmail = '';
  String driverPhone = '';
  String driverNationalID = '';
  String driverBussNo = '';
  RxString driverLicence = ''.obs;
  String sendNotification = '';

  final List<String> blood = ["B+", "A+", "B-", "A-"];
  RxList<String> buses = ['B1', 'C1', 'D1'].obs;
  RxString selectedBus = ''.obs;
  RxString driverBlood = ''.obs;
  RxString driverBDate = ''.obs;
  RxBool _isLoading = false.obs; // Add this variable
  RxBool get isLoading => _isLoading;

  TextEditingController bDate = TextEditingController();

  void clearData() {
    driverFName = '';
    driverLName = '';
    driverEmail = '';
    driverPhone = '';
    driverBlood.value = '';
    driverBDate.value = '';
    driverNationalID = '';
    driverLicence.value = '';
    driverBussNo = '';
  }

  Future<bool> saveDriver() async {
    try {
      DatabaseHelper dbHelper = DatabaseHelper();
      AuthService authService = AuthService();
      String? userId = await authService.createUserWithEmailAndPassword(
          driverEmail, "123456");

      final driver = DriverModel(
        id: userId!,
        fName: driverFName,
        lName: driverLName,
        email: driverEmail,
        phone: driverPhone,
        nationalId: driverNationalID,
        isEnabled: true,
        driverBDate: bDate.text,
        blood: driverBlood.value,
        driverLicence: driverLicence.value,
        busId: driverBussNo,
      );
      await dbHelper.saveDriver(driver, 'drivers');
      await authService.resetPassword(driverEmail);
      _isLoading(false);
      return true;
    } catch (e) {
      _isLoading(false);
      return false;
    }
  }
}
