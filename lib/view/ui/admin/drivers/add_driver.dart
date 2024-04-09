import 'package:ameen/controller/admin_controller.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/widget/text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../controller/camera_controller.dart';
import '../../../../utils/validation.dart';
import '../../widget/custem_dropdown_menu.dart';

AdminController controller = Get.find();

Future<void> _selectDate(BuildContext context) async {
  final selected = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1980, 1, 1),
    lastDate: DateTime.now(),
  );
  if (selected != null && selected != DateTime.now()) {
    // controller.selectedDate = selected;
    controller.bDate.text =
        "${selected.year}-${selected.month}-${selected.day}";
    print(controller.driverBDate.value);
  }
}

class AddDriver extends StatefulWidget {
  const AddDriver({super.key});

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  bool _isLoading = false;
  final CamController camController =
      Get.find(); // Assuming GetX controller instance
  String? _selectedImagePath; // Store the selected image path
  String? licenceImgUrl;
  String? driverPhoto;
  AdminController adminController = Get.find();

  Future<void> _handleCameraPick(
      ImageSource imageSource, String fullName) async {
    setState(() {
      _isLoading = true; // Set loading state to false
    });
    final response = await camController.takeDriverPhotoFromCamera(imageSource);
    setState(() {
      _selectedImagePath = camController.picture.path;
    });
    if (response == 200) {
      // Assuming success code is 200
      licenceImgUrl = camController.driverImgUrl.value;
      if (licenceImgUrl != null) {
        controller.driverLicence.value = licenceImgUrl!;
        print("Image url: $licenceImgUrl");
      } else if (driverPhoto! != null){

      }else {
        print("Image url not found");
      }
      setState(() {
        _selectedImagePath = camController.picture.path;
      });
    }
    setState(() {
      _isLoading = false; // Set loading state to false
    });
  }

  void _showImageOptionsDialog(BuildContext context) async {
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    if (cameraStatus.isGranted && storageStatus.isGranted) {
      final imagePicker = ImagePicker();

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('أختر طريقة أخذ الصورة'),
            content: Column(
              mainAxisSize: MainAxisSize.min, // Don't let content overflow
              children: [
                ListTile(
                  title: const Text('الكاميرا'),
                  onTap: () => _handleCameraPick(ImageSource.camera,
                      '${controller.driverFName}_${controller.driverLName}_1'),
                ),
                ListTile(
                  title: const Text('معرض الصور'),
                  onTap: () => _handleCameraPick(ImageSource.gallery,
                      '${controller.driverFName}_${controller.driverLName}_1'),
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Handle permission denied case (e.g., show a message)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please grant camera and storage permissions'),
        ),
      );
    }
  }

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Validation validation = Validation();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Form(
      key: key,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 113, 65, 146),
            centerTitle: true,
            title: const Text("اضافة سائق جديد"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.02),
                  child: TextFieldModel(
                    keyboardType: TextInputType.name,
                    validator: (val) => validation.validator(val),
                    onChanged: (val) {
                      controller.driverFName = val;
                    },
                    text: "الاسم الاول",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.02),
                  child: TextFieldModel(
                    keyboardType: TextInputType.name,
                    validator: (val) => validation.validator(val),
                    onChanged: (val) {
                      controller.driverLName = val;
                    },
                    text: "الاسم الأخير",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.02),
                  child: TextFieldModel(
                    validator: (val) => validation.validator(val),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (val) {
                      controller.driverNationalID = val;
                    },
                    text: "رقم الاحوال",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.02),
                  child: TextFieldModel(
                    validator: (val) => validation.phoneValidator(val),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 10,
                    onChanged: (val) {
                      controller.driverPhone = val;
                    },
                    keyboardType: TextInputType.number,
                    text: "رقم الجوال",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.02),
                  child: TextFieldModel(
                    validator: (val) => validation.emailValidator(val),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      controller.driverEmail = val;
                    },
                    text: "البريد الإلكتروني",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.02),
                  child: TextFieldModel(
                    onTap: () => _selectDate(context),
                    validator: (val) => validation.validator(val),
                    readOnly: true,
                    controller: controller.bDate,
                    onChanged: (value) {
                      controller.driverBDate.value = value;
                    },
                    sufIcon: Icon(
                      IconlyLight.calendar,
                      size: width * 0.055,
                    ),
                    keyboardType: TextInputType.datetime,
                    text: "تاريخ الميلاد",
                    // vPadding: height * 0.03,
                    obscureText: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.02),
                  child: Obx(() => CustomDropdownButton2(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: width * 0.055,
                      ),
                      buttonHeight: height * 0.07,
                      buttonWidth: width,
                      // dropdownWidth: 20,
                      hint: 'فصيلة الدم',
                      value: controller.driverBlood.value.isEmpty
                          ? null
                          : controller.driverBlood.value,
                      dropdownItems: controller.blood,
                      onChanged: (val) {
                        controller.driverBlood.value = val!;
                      })),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.03,
                    ),
                    GestureDetector(
                      onTap: () => _showImageOptionsDialog(context),
                      child: Container(
                          height: height * 0.13,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(11)),
                          width: width * 0.45,
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.01),
                          child: DottedBorder(
                            stackFit: StackFit.expand,
                            borderPadding: EdgeInsets.all(width * 0.027),
                            color: Colors.black38,
                            borderType: BorderType.RRect,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconlyLight.image, size: width * 0.07,color: PRIMARY_COLOR),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text("ادراج الصوره الشخصيه", style: TextStyle(fontSize: width * 0.036),)
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    GestureDetector(
                      onTap: () => _showImageOptionsDialog(context),
                      child: Container(
                          height: height * 0.13,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(11)),
                          width: width * 0.45,
                          alignment: Alignment.center,
                          padding:
                          EdgeInsets.symmetric(horizontal: width * 0.01),
                          child: DottedBorder(

                            stackFit: StackFit.expand,
                            borderPadding: EdgeInsets.all(width * 0.027),
                            color: Colors.black38,
                            borderType: BorderType.RRect,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconlyLight.image, size: width * 0.07,color: PRIMARY_COLOR),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text("ادراج صوره رخصه القياده", style: TextStyle(fontSize: width * 0.036),)
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.02),
                  child: TextFieldModel(
                    validator: (val) => validation.validator(val),
                    onChanged: (val) {
                      controller.driverBussNo = val;
                    },
                    text: "رقم الباص ",
                  ),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : () => _saveDriver(),
                  // Disable button when loading
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.02,
                      horizontal: width * 0.2,
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator() // Show loading indicator
                      : const Text(
                          "حفظ",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveDriver() async {
    // Validate form
    if (key.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Set loading state to true
      });

      // Call saveDriver method from controller
      final result = await controller.saveDriver();
      print("result is $result");

      setState(() {
        _isLoading = false; // Set loading state to false
      });

      // Navigate back
      Get.back();
      controller.clearData();
      Get.back();
    } else {
      print("error");
    }
  }
}
