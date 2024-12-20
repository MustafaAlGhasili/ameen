// import 'package:camera/camera.dart';
import 'package:Amin/model/admin.dart';
import 'package:Amin/model/driver.dart';
import 'package:Amin/model/parent.dart';
import 'package:Amin/utils/constant.dart';
import 'package:Amin/utils/general_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/school.dart';
import '../model/student.dart';
import '../services/LocalStorageService.dart';
import '../services/firebase_notification.dart';
import '../utils/DatabaseHelper.dart';

class SignController extends GetxController {
  RxBool visibility = false.obs;
  bool isLocationPicked = false;
  RxBool canGo = false.obs;

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
  final studentPhone = TextEditingController();
  final studentEmail = TextEditingController();

  String? signInEmailCont = '';
  String? signInPassCont = '';
  final emailVerificationCont = TextEditingController();

  String forgetPassword = '';
  String code = '';

  String studentId = generateRandomFirebaseId();

  DateTime? selectedDate;

  bool hasError = false;
  var onTapRecognizer;
  RxInt step = 0.obs;

  RxList<String> blood = ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'].obs;
  RxString bloodValue = ''.obs;
  RxString loginErrorValue = ''.obs;

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
  }.obs;

  RxMap<String, int> schools = {
    'مدرسة النور': 1,
    'مدرسة العلم': 2,
  }.obs;

  RxList<SchoolModel> generalSchoolsList = <SchoolModel>[].obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  RxBool isAccepted = false.obs;
  late DatabaseHelper _databaseHelper;

  String fileNameValue = '';

  String get fileName => fileNameValue;

  late FirebaseAuth _auth;

  changeVisibility() {
    visibility.value = !visibility.value;
  }

  @override
  void onInit() {
    _databaseHelper = DatabaseHelper();
    _auth = FirebaseAuth.instance;
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Get.back(closeOverlays: true);
      };
    // errorController = StreamController<ErrorAnimationType>();
    super.onInit();
    addSchoolsToMenu();
  }

  Future<bool> _requestPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status == PermissionStatus.granted;
  }

  bool mapSelected = false;

  Future<void> getLocation(BuildContext context) async {
    if (await _requestPermission()) {
      LocationResult? result = await showLocationPicker(
          context, "AIzaSyBlHVCC3b6bsDxyJAPL7rsdkDarJYd-SeI",
          initialCenter: const LatLng(40.7128, -74.0060),
          layersButtonEnabled: true,
          desiredAccuracy: LocationAccuracy.bestForNavigation,
          language: 'ar',
          countries: ['SA'],
          requiredGPS: true,
          searchBarBoxDecoration: null,
          // Set searchBarBoxDecoration to null to hide the search bar
          appBarColor: Colors.white);

      if (result != null) {
        print("Selected location:");
        print("Address: ${result.address}");
        print("LatLng: ${result.latLng.latitude}, ${result.latLng.longitude}");
        mapSelected = true;
        update();
        latitude.value = result.latLng.latitude;
        longitude.value = result.latLng.longitude;
        isLocationPicked = true;
      } else {
        print("Location picking canceled");
      }
    } else {
      print("Permission denied");
    }
  }

  RxBool _isLoading = false.obs; // Add this variable
  RxBool get isLoading => _isLoading;

  // void setLoading(RxBool loading) {
  //   print("loading is $loading");
  //   _isLoading.value = loading.value;
  //   update(); // Update UI when loading state changes
  // }

  Future<void> testDBQuery() async {
    print("testDBQuery Called");
    await _databaseHelper.getStudentsOfDisabledParents();
  }

  Future<bool> registerParent() async {
    _isLoading(true);
    try {
      print(parentFName.text);
      print(parentLName.text);
      print(parentEmail.text);
      print(parenPassword.text);
      String? parentId = await createUserWithEmailAndPassword(
          parentEmail.text, parenPassword.text);
      final parent = ParentModel(
        id: parentId!,
        fName: parentFName.text,
        lName: parentLName.text,
        nationalId: parentNationalId.text,
        email: parentEmail.text,
        isEnabled: false,
        //TODO Change it after admin
        phone: parentPhone.text,
      );

      await _databaseHelper.saveParent(parent, "parents");

      String imgUrl = "${Constants.STUDENT_IMAGES_URL}${fileNameValue}";
      print("Value = $fileNameValue.");
      //
      final student = StudentModel(
        fName: studentFName.text,
        lName: studentLName.text,
        nationalId: studentNationalId.text,
        birthDate: studentBDate.text,
        gender: genderValue.value,
        blood: bloodValue.value,
        isEnabled: false,
        parentId: parentId!,
        schoolId: generalSchoolsList[schoolValue.value! - 1].id!,
        grade: gradeValue.value,
        latitude: latitude.value,
        longitude: longitude.value,
        address: address.text,
        imgUrl: imgUrl,
        email: studentEmail.text,
        phone: studentPhone.text,
      );

      print("Student");
      print("Student school:" + student.imgUrl!);

      studentId = studentId.replaceAll('_', '');
      student.id = studentId;
      await _databaseHelper.saveStudent(student);
      await LocalStorageService.saveParent(parent);
      await LocalStorageService.saveStudent(student);
      print("saved");
      _isLoading(false);
      return true;
    } catch (e) {
      _isLoading(false);
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    print("Email is $email");
    _isLoading(true);

    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      _isLoading(false);
      return true;
      print("Password reset email sent successfully");
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException errors
      print("FirebaseAuthException - Code: ${e.code}, Message: ${e.message}");
      if (e.code == 'user-not-found') {
        // Handle user not found error
        print('User not found. Please check the email address.');
      } else {
        // Handle other errors as needed
        print('Error sending password reset email: $e');
      }
      _isLoading(false);

      return false;
    } catch (e) {
      // Handle other exceptions
      print('Error sending password reset email: $e');
      _isLoading(false);
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(
      String email, String password, int loginType) async {
    print('Sign is email: $email And Pass is $password');
    _isLoading(true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = userCredential.user?.uid ?? '';
      print('User ID: $userId');
      LocalStorageService.saveUserType(loginType);
      if (loginType == 0) {
        ParentModel? parent =
            await _databaseHelper.getUserById<ParentModel>(userId, loginType);
        print("Found Parent");
        FirebaseNotification firebaseNotification = FirebaseNotification();
        await firebaseNotification.initialize();
        await firebaseNotification.subscribeToTopic("parents");
        print(parent);
        if (parent != null) {
          if (!parent.isEnabled) {
            _isLoading(false);
            loginErrorValue.value = "في إنتظار تفعيل حسابك";
            return false;
          }
          StudentModel? student =
              await _databaseHelper.getStudentByParentId(parent.id);

          print("Found Student $student");
          await LocalStorageService.saveParent(parent);
          await LocalStorageService.saveStudent(student!);
          return true;
        }
      } else if (loginType == 1) {
        DriverModel? driver =
            await _databaseHelper.getUserById<DriverModel>(userId, loginType);
        print("Found Driver");
        print(driver);
        if (driver != null) {
          if (!driver.isEnabled) {
            _isLoading(false);
            loginErrorValue.value = "في إنتظار تفعيل حسابك";
            return false;
          }
          await LocalStorageService.saveDriver(driver);
          _isLoading(false);
          return true;
        } else {
          print("No Data for driver");
          loginErrorValue.value = "لايوجد بيانات للسائق";
          return false;
        }
      } else {
        AdminModel? admin =
            await _databaseHelper.getUserById<AdminModel>(userId, loginType);
        print("Found Admin");
        print(admin);
        if (admin == null) {
          _isLoading(false);
          loginErrorValue.value = "لست مشرف";
          return false;
        }
        _isLoading(false);
        return true;
      }
      _isLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      print("eeeeeee $e codeeee ${e.code}");
      if (e.code == "network-request-failed") {
        loginErrorValue.value = "network-request-failed";
      } else if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        loginErrorValue.value = "الإيميل او كلمة المرور خاطئة";
      } else if (e.code == 'user-disabled') {
        loginErrorValue.value = "الحساب موقف حالياُ";
      } else if (e.code == 'channel-error') {
        loginErrorValue.value = "حصل خطأ الرجاء المحاوله مره اخرى";
      } else {
        loginErrorValue.value = "حدث خطأ الرجاء اعاده المحاوله";
      }
      _isLoading(false);
      return false;
    } catch (e) {
      print("Error: $e");
      loginErrorValue.value = e.toString();
      _isLoading(false);
      return false;
    }
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    print("Started Creating New User ");
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the newly created user's ID
      final String userId = userCredential.user!.uid;
      canGo = true.obs;
      // Perform any additional actions, e.g., store user data, navigate to a different screen
      print('User created successfully: $userId');
      return userId;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException - Code: ${e.code}, Message: ${e.message}');

      if (e.code == 'weak-password') {
        loginErrorValue.value = "كلمه السر ضعيفه";
        print('The password provided is too weak.');
        // Get.showSnackbar(const GetSnackBar(
        //   borderRadius: 20,
        //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //   icon: Icon(
        //     IconlyLight.info_circle,
        //     color: Colors.white,
        //   ),
        //   title: "خطأ",
        //   message: "كلمه السر ضعيفه",
        //   duration: Duration(seconds: 2),
        //   animationDuration: Duration(milliseconds: 600),
        // ));
      } else if (e.code == 'email-already-in-use') {
        loginErrorValue.value = "الايميل مستخدم في حساب اخر";

        print('The email address is already in use by another user.');
      } else {
        print("Error");
        print(e.code);
      }

      Get.showSnackbar(
        GetSnackBar(
          borderRadius: 20,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          icon: const Icon(
            IconlyLight.info_circle,
            color: Colors.white,
          ),
          title: "خطأ",
          message: loginErrorValue.value,
          duration: const Duration(seconds: 2),
          animationDuration: const Duration(milliseconds: 600),
        ),
      );
    } catch (e) {
      print(e); // Handle other exceptions
    }
    return null;
  }

  void addSchoolsToMenu() async {
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

  void clear() {
    step = 0.obs;
    parentFName.clear();
    parentLName.clear();
    parentEmail.clear();
    parentNationalId.clear();
    parentPhone.clear();
    parenPassword.clear();
    address.clear();
    studentFName.clear();
    studentLName.clear();
    studentPhone.clear();
    studentEmail.clear();
    studentNationalId.clear();
    studentBDate.clear();
  }
}
