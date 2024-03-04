// import 'package:camera/camera.dart';
import 'package:ameen/model/parent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/school.dart';
import '../model/student.dart';
import '../utils/DatabaseHelper.dart';

class SignController extends GetxController {
  RxBool visibility = true.obs;

  final parentFName = TextEditingController();
  final address = TextEditingController();
  final parentEmail = TextEditingController();
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
  RxInt schoolValue = 0.obs;
  RxInt gradeValue = 0.obs;

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

  RxMap<String, int> schools = {
    'مدرسة النور': 1,
    'مدرسة العلم': 2,
  }.obs;

  RxList<SchoolModel> generalSchoolsList = <SchoolModel>[].obs;

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
    //addSchoolsToMenu();
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
    String? parentId = await createUserWithEmailAndPassword(
        parentEmail.text, parenPassword.text);
    final parent = ParentModel(
      id: parentId!,
      fName: parentFName.text,
      lName: parentLName.text,
      nationalId: parentNationalId.text,
      email: parentEmail.text,
      isEnabled: false,
      phone: parentPhone.text,
    );

    await _databaseHelper.saveParent(parent, "parents");

    final student = StudentModel(
      fName: studentFName.text,
      lName: studentLName.text,
      nationalId: studentNationalId.text,
      birthDate: studentBDate.text,
      gender: genderValue.value,
      blood: bloodValue.value,
      isEnabled: false,
      parentId: parentId!,
      schoolId: generalSchoolsList[schoolValue.value!-1].id!,
      grade: gradeValue.value,
      latitude: latitude.value,
      longitude: longitude.value,
      address: address.text,
    );

    print("Student");
    print("Student school:" + student.schoolId);
    print(student.grade);
    print(student.toMap());

    String? studentId =
        await _databaseHelper.save<StudentModel>(student, "students");
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the newly created user's ID
      final String userId = userCredential.user!.uid;

      // Perform any additional actions, e.g., store user data, navigate to a different screen
      print('User created successfully: $userId');
      return userId;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException - Code: ${e.code}, Message: ${e.message}');

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The email address is already in use by another user.');
      } else {
        print("Error");
        print(e.code);
      }
    } catch (e) {
      print(e); // Handle other exceptions
    }
    return null;
  }

  void addSchoolsToMenu() async {
    DatabaseHelper _databaseHelper = DatabaseHelper();
    List<SchoolModel> schoolsList = await _databaseHelper.getAllSchools();
    generalSchoolsList = schoolsList.obs;
    print("School Id");
    print(schools);
    int count = 1;
    schools.clear();
    for (var school in schoolsList) {
      schools[school.name!] = count;
      count++;
      // Access school properties here
      print('School ID: ${school.id}');
      print('School Name: ${school.name}');
      // Add any other properties you want to access
    }
  }
}
