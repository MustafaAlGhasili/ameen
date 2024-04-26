import 'package:ameen/controller/sign_controller.dart';
import 'package:ameen/model/absence.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/parent.dart';
import '../services/LocalStorageService.dart';
import '../utils/DatabaseHelper.dart';

class HomeController extends GetxController {
  SignController controller = Get.find<SignController>();

  RxInt bottomIndex = 0.obs;
  RxBool map = false.obs;
  late DatabaseHelper _databaseHelper;

  // final parentFName = TextEditingController();
  // final parentLName = TextEditingController();
  // final parentSN = TextEditingController();
  // final parentNumber = TextEditingController();
  // final parentPassword = TextEditingController();

  RxBool isInTheWay = false.obs;
  RxBool isClose = false.obs;
  RxBool isArrived = false.obs;
  RxBool notificationOn = true.obs;

  @override
  void onInit() {
    _databaseHelper = DatabaseHelper();
    super.onInit();
  }

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

  Future<bool> createAbsenceRequest() async {
    try {
      final student = await LocalStorageService.getStudent();
      if (student == null) {
        print("No Student in local");
        return false;
      }

      final String createdAt = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final absence = AbsenceModel(studentId: student.id, createdAt: createdAt);
      String? absenceId = await _databaseHelper.saveAbsence(absence);
      print("absence Created with Id:$absenceId");
      return true;
    } catch (e) {
      // Handle other exceptions
      print('Error creating absence: $e');
      return false;
    }
  }

  Future<void> changeStudentTracking() async {
    try {
      final student = await LocalStorageService.getStudent();
      if (student == null) {
        print("No Student in local");
        return;
      }
      final studentStatus =
          await _databaseHelper.trackStudentStatus(student.busId!);
      isInTheWay = false.obs;
      isClose = false.obs;
      isArrived = false.obs;

      isInTheWay = (studentStatus!.status >= 0).obs;
      isClose = (studentStatus.status > 2).obs;
      isArrived = (studentStatus.status == 3).obs;
    } catch (e) {
      // Handle other exceptions
      print('Error creating absence: $e');
      return;
    }
  }
}
