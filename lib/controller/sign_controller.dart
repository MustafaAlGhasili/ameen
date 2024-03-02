// import 'package:camera/camera.dart';
import 'package:ameen/model/parent.dart';
import 'package:ameen/model/student.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

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

  void sendDataToDatabase() async {
    //   //parent reference
    //   DatabaseReference pRef = FirebaseDatabase.instance.ref("parent");
    //   DatabaseEvent databaseEvent = await pRef.once();
    //   DataSnapshot snapshot = databaseEvent.snapshot;
    //   print(snapshot.value);
    //   Map<String, dynamic>? map = (snapshot.value == null ? null : snapshot.value)
    //       as Map<String, dynamic>?;
    //   map?.forEach((key, value) {
    //     Map m = {"key": key};
    //     m.addAll(value);
    //     l.add(value);
    //   });
    // }

    final parentDBRef = FirebaseDatabase.instance.ref().child('parents').push();
    final studentDBRef = FirebaseDatabase.instance.ref().child('student').push();
   

    final parent = ParentModel(
      id: "${parentDBRef.key}",
      fName: parentFName.text,
      lName: parentLName.text,
      nationalId: parentNationalId.text,
      email: 'email',
      isEnabled: false,
      phone: parentPhone.text,
      chiledID: "${studentDBRef.key}",
    );

    final student = StudentModel(
        id: "${studentDBRef.key}",
        fName: studentFName.text,
        lName: studentLName.text,
        nationalId: studentNationalId.text,
        isEnabled: false,
        birthDate: studentBDate.text,
        sex: studentSex.text,
        blood: studentBlood.text,
        parent: "${parentDBRef.key}");

    await parentDBRef.set(parent.toMap());
    await studentDBRef.set(student.toMap());
  }
}
