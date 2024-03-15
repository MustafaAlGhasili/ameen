import 'package:ameen/controller/admin_controller.dart';
import 'package:ameen/model/driver.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/admin/drivers/drivers_list.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:ameen/view/ui/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../controller/camera_controller.dart';
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
  final CamController camController =
      Get.find(); // Assuming GetX controller instance
  String? _selectedImagePath; // Store the selected image path

  Future<void> _handleCameraPick(
      ImageSource imageSource, String fullName) async {
    final response =
        await camController.takeDriverPhotoFromCamera(imageSource);
    setState(() {
      _selectedImagePath = camController.picture.path;
    });
    if (response == 200) {
      // Assuming success code is 200
      setState(() {
        _selectedImagePath = camController.picture.path;
      });
    }
    // Handle other response codes
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
                      '${controller.driverBlood}_${controller.driverBDate}_1'),
                ),
                ListTile(
                  title: const Text('معرض الصور'),
                  onTap: () => _handleCameraPick(ImageSource.gallery,
                      '${controller.driverBlood}_${controller.driverBDate}_1'),
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
                    controller: controller.bDate,

                    sufIcon: IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(
                          IconlyLight.calendar,
                          size: width * 0.055,
                        )),

                    keyboardType: TextInputType.datetime,
                    text: "تاريخ الميلاد",
                    // vPadding: height * 0.035,
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.02),
                  child: GestureDetector(
                    onTap: () => _showImageOptionsDialog(context),
                    child: TextFieldModel(
                      onChanged: (val) {
                        controller.driverLicence = val;
                      },
                      isEnabled: false,
                      sufIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      text: "ادراج صورة من رخصة القيادة",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.02),
                  child: TextFieldModel(
                    onChanged: (val) {
                      controller.driverBussNo = val;
                    },
                    text: "رقم الباص ",
                  ),
                ),
                ButtonModel(
                  onTap: () {
                    if (key.currentState!.validate()) {
                      DatabaseHelper dbHelper = DatabaseHelper();
                      dbHelper.save(
                          DriverModel(
                            fName: controller.driverFName,
                            lName: controller.driverLName,
                            phone: controller.driverPhone,
                            nationalId: controller.driverNationalID,
                            isEnabled: false,
                            driverBDate: controller.driverBDate.value,
                            blood: controller.driverBlood.value,
                            driverLicence: controller.driverLicence,
                            busId: controller.driverBussNo,
                          ),
                          'drivers');
                      Get.back();
                      controller.clearData();
                    } else {
                      print("error");
                    }
                  },
                  content: "حفط",
                  rowMainAxisAlignment: MainAxisAlignment.center,
                  backColor: PRIMARY_COLOR,
                  height: height * 0.06,
                  hMargin: width * 0.07,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
