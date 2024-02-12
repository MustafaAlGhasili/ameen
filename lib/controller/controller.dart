import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignController extends GetxController {
  RxBool visibility = true.obs;
  String? email;
  String? password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hasError = false;
  late StreamController<ErrorAnimationType> errorController;
  TextEditingController otpController = TextEditingController();
  var onTapRecognizer;
  String value = '';



  changeVisibility() {
    visibility.value = !visibility.value;
  }

  @override
  void onInit() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
       Get.back(closeOverlays: true);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.onInit();
  }


}
