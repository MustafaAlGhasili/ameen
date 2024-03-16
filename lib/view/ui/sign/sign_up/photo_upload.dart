import 'dart:io';

import 'package:ameen/controller/sign_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../controller/camera_controller.dart';
import '../../widget/button_model.dart';
import 'sign_up.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final CamController camController = Get.find();
  final SignController signController = Get.find();
  String? _selectedImagePath;
  bool _isLoading = false;

  Future<void> _handleCameraPick(
      ImageSource imageSource, String fullName) async {
    setState(() {
      _isLoading = true;
    });

    final response =
        await camController.takePhotoFromCamera(imageSource, fullName);
    setState(() {
      _selectedImagePath = camController.picture.path;
      signController.fileNameValue.value = camController.fileNameValue.value;
      _isLoading = false;
    });

    if (response == 200) {
      setState(() {
        _selectedImagePath = camController.picture.path;
      });
    }
  }

  void _showImageOptionsDialog(BuildContext context) async {
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    if (cameraStatus.isGranted && storageStatus.isGranted) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('أختر طريقة أخذ الصورة'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('الكاميرا'),
                  onTap: () {
                    _handleCameraPick(
                      ImageSource.camera,
                      '${controller.studentFName.text}_${controller.studentLName.text}_1',
                    );
                    Navigator.of(context).pop(); // Close dialog
                  },
                ),
                ListTile(
                  title: const Text('معرض الصور'),
                  onTap: () {
                    _handleCameraPick(
                      ImageSource.gallery,
                      '${controller.studentFName.text}_${controller.studentLName.text}_1',
                    );
                    Navigator.of(context).pop(); // Close dialog
                  },
                ),
              ],
            ),
          );
        },
      );
    } else {
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
              _selectedImagePath != null
                  ? Image.file(
                      File(_selectedImagePath!),
                      width: width,
                      height: height * 0.3,
                    )
                  : const SizedBox.shrink(),
              IconButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        _showImageOptionsDialog(context);
                      },
                icon: Icon(
                  Icons.add_a_photo,
                  size: width * 0.3,
                  color: const Color.fromARGB(255, 113, 65, 146),
                ),
              ),
              SizedBox(height: height * 0.02),
              _isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
              SizedBox(height: height * 0.02),
              ButtonModel(
                onTap: () {
                  controller.step.value++;
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
