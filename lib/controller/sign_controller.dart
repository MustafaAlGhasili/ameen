// import 'package:camera/camera.dart';
import 'package:ameen/model/parent.dart';
import 'package:ameen/model/student.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/DatabaseHelper.dart';

class SignController extends GetxController {
  RxBool visibility = true.obs;

  final parentFName = TextEditingController();
  final parentLName = TextEditingController();
  final parentPhone = TextEditingController();
  final parentNationalId = TextEditingController();
  final parenPassword = TextEditingController();

  final studentFName = TextEditingController();
  final studentLName = TextEditingController();
  final studentNationalId = TextEditingController();
  final studentBDate = TextEditingController();
  final studentBlood = TextEditingController();
  final studentSex = TextEditingController();

  final signInEmailCont = TextEditingController();
  final signInPassCont = TextEditingController();
  final emailVerificationCont = TextEditingController();

  String forgetPassword = '';
  String code = '';

  DateTime? selectedDate;

  bool hasError = false;
  var onTapRecognizer;
  RxInt step = 1.obs;

  RxList<String> blood = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'].obs;
  RxString bloodValue = ''.obs;

  RxList<String> genders = ['ذكر', 'أنثى'].obs;
  RxString genderValue = ''.obs;

  RxMap<String, int> grades = {
    'رياض الأطفال': 0,
    'الصف الأول': 1,
    'الصف الثاني': 2,
    'الصف الثالث': 3,
    'الصف الرابع': 4,
    'الصف الخامس': 5,
    'الصف السادس': 6,
    'الصف السابع': 7,
    'الصف الثامن': 8,
    'الصف التاسع': 9,
  }.obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  RxBool isAccepted = false.obs;

  changeVisibility() {
    visibility.value = !visibility.value;
  }

  @override
  void onInit() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Get.back(closeOverlays: true);
      };
    // errorController = StreamController<ErrorAnimationType>();
    super.onInit();
  }

  Future<bool> _requestPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status == PermissionStatus.granted;
  }

  Future<void> getLocation(BuildContext context) async {
    if (await _requestPermission()) {
      LocationResult? result = await showLocationPicker(
        context,
        "AIzaSyBlHVCC3b6bsDxyJAPL7rsdkDarJYd-SeI",
        initialCenter: const LatLng(40.7128, -74.0060),
        layersButtonEnabled: true,
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        language: 'ar',
        countries: ['SA'],
        requiredGPS: true,
        searchBarBoxDecoration:
            null, // Set searchBarBoxDecoration to null to hide the search bar
      );

      if (result != null) {
        print("Selected location:");
        print("Address: ${result.address}");
        print("LatLng: ${result.latLng.latitude}, ${result.latLng.longitude}");

        latitude.value = result.latLng.latitude;
        longitude.value = result.latLng.longitude;
      } else {
        print("Location picking canceled");
      }
    } else {
      print("Permission denied");
    }
  }

  void registerParent() async {
    DatabaseHelper _databaseHelper = DatabaseHelper();

    print(parentFName.text);
    print(parentLName.text);

    final parent = ParentModel(
      fName: parentFName.text,
      lName: parentLName.text,
      nationalId: parentNationalId.text,
      email: 'email',
      isEnabled: false,
      phone: parentPhone.text,
    );

    String? parentId =
        await _databaseHelper.save<ParentModel>(parent, "parents");

  }

}
