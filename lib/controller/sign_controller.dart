// import 'package:camera/camera.dart';
import 'package:ameen/view/ui/sign/signup_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

class SignController extends GetxController {
  RxBool visibility = true.obs;

  final signInEmailCont = TextEditingController();
  final signInPassCont = TextEditingController();
  final emailVerificationCont = TextEditingController();

  String forgetPassword = '';
  String code = '';

  bool hasError = false;
  var onTapRecognizer;
  RxInt step = 0.obs;
  RxList blood = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'].obs;
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

  Map parentInfo = {
    'fName' : '',
  };
  void sendDataToDatabase(Parent parent) async {
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

    final dbRef = FirebaseDatabase.instance.ref('parents');
    final parent = ParentModel(
      id: "${dbRef.push().key}",
      fName: parentInfo['fName'],
      email: 'johndoe@example.com',
      isEnabled: false,
      lName: '',
      phone: '',
      nationalId: '',
    );
    await dbRef.push().set(parent.toMap());
  }
}

class ParentModel {
  final String id;
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String nationalId;
  final bool isEnabled;

  ParentModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.isEnabled,
  });

  // Convert model to a map for storing in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstNname': fName,
      'lastName': lName,
      'email': email,
      'phone': phone,
      'nationalId': nationalId,
      'isEnabled': isEnabled,
    };
  }
}
