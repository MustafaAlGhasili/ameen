import 'dart:io';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../controller/camera_controller.dart';
import '../../widget/button_model.dart';
import 'sign_up.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final CamController camController =
      Get.find(); // Assuming GetX controller instance
  String? _selectedImagePath; // Store the selected image path

  Future<void> _handleCameraPick(
      ImageSource imageSource, String fullName) async {
    final response =
        await camController.takePhotoFromCamera(imageSource, fullName);
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
            title: const Text('أختر طريقة أخذ الصورة'),
            content: Column(
              mainAxisSize: MainAxisSize.min, // Don't let content overflow
              children: [
                ListTile(
                  title: const Text('الكاميرا'),
                  onTap: () => _handleCameraPick(ImageSource.camera,
                      '${controller.studentFName.text}_${controller.studentLName.text}_1'),
                ),
                ListTile(
                  title: const Text('معرض الصور'),
                  onTap: () => _handleCameraPick(ImageSource.gallery,
                      '${controller.studentFName.text}_${controller.studentLName.text}_1'),
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Handle permission denied case (e.g., show a message)
      Get.showSnackbar(
        GetSnackBar(
          borderRadius: 20,
          margin: EdgeInsets.symmetric(
              horizontal: Get.width * 0.045, vertical: Get.height * 0.015),
          icon: Icon(
            IconlyLight.info_circle,
            color: Colors.white,
            size: Get.width * 0.065,
          ),
          title: "Error",
          message: "Please grant camera and storage permissions",
          duration: const Duration(seconds: 3),
          animationDuration: const Duration(milliseconds: 600),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Center(
      child: Stack(
        children: [
           Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display selected image if available
                    _selectedImagePath != null
                        ? Image.file(
                            File(_selectedImagePath!),
                            // Adjust width and height as needed
                            width: width,
                            height: height * 0.3, // Adjust height as needed
                          )
                        : const SizedBox.shrink(),

                    // Your image upload icon
                    IconButton(
                      onPressed: () {
                        _showImageOptionsDialog(context);
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        size: width * 0.3, // Adjust the size as needed
                        color: const Color.fromARGB(255, 113, 65, 146),
                      ),
                    ),
                    SizedBox(height: height * 0.02), // Adjust spacing as needed

                    // Your next button
                    ButtonModel(
                      onTap: () {
                        controller.step.value++;
                        // Get.to(() => const StudentInfo());
                      },
                      width: width * 0.9,
                      height: height * 0.06,
                      content: 'التالي',
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      textAlign: TextAlign.center,
                      backColor: const Color.fromARGB(255, 113, 65, 146),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
