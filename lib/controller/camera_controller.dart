import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


late List<CameraDescription> cameras;

class CamController extends GetxController {
  late CameraController cameraController;
  late XFile picture;
  Uint8List? _imageBytes;
  final ImagePicker _imagePicker = ImagePicker();

  bool _isLoading = false; // Add this variable
  bool get isLoading => _isLoading;


  void setLoading(bool loading) {
    _isLoading = loading;
    update(); // Update UI when loading state changes
  }

  @override
  void onInit() {
    initializeControllerFuture();
    super.onInit();
  }

  Future<void> initializeControllerFuture() async {
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.veryHigh,
    );
    try {
      await cameraController.initialize();
    } catch (e) {
      print('Error initializing camera: $e');
    }

    if (!isClosed) return;
    update();
  }

  Future<int> registerBusVisitorFace({required File file}) async {

    String fileExtension = extension(file.path);
    String fileName = "test${Random().nextInt(1000)}$fileExtension";

    print('File Name: $fileName');

    String studentName = "Moha_Hasan_2444";
    final String url =
        'https://nfaa7msxkb.execute-api.us-east-1.amazonaws.com/dev/bus-visitors-2-2/$fileName'; // Replace with your API Gateway endpoint
/*
    final String url =
        'https://nfaa7msxkb.execute-api.us-east-1.amazonaws.com/dev/students-images-4-4/$studentName'; // Replace with your API Gateway endpoint
*/

    try {
      Uint8List image = File(file.path).readAsBytesSync();

      Options options = Options(contentType: 'image/jpg', headers: {
        'Accept': "*/*",
        'Content-Length': image.length,
        'Connection': 'keep-alive',
        'User-Agent': 'ClinicPlush'
      });
      final response = await Dio().put(url,
          data: Stream.fromIterable(image.map((e) => [e])), options: options);
      print(response);

      if (response.statusCode == 200) {
        Get.back(closeOverlays: true);
        // Image uploaded successfully.
        print('Image uploaded successfully!');

        // await Future.delayed(const Duration(seconds: 1));

        return makeGetRequest(fileName);
      } else {
        Get.back(closeOverlays: true);
        // Failed to upload image.
        print('Failed to upload image: ${response.statusMessage}');
      }
      Get.back(closeOverlays: true);
      return 500;
    } on DioException catch (error) {
      Get.back(closeOverlays: true);
      print("object ${error.message}");
      if (error.message!.contains("The connection errored: Failed host lookup:")) {

        Get.snackbar('Error', "pleas connect to the internet",
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
            animationDuration: const Duration(milliseconds: 700),
            backgroundColor: Colors.black);
        // GetSnackBar(
        //
        //   messageText: Text("pleas connect to the internet",
        //       style: TextStyle(color: Colors.white)),
        //   titleText: Text("Error", style: TextStyle(color: Colors.white)),
        //   icon: Icon(Icons.error_outline, color: Colors.white),
        //   duration: Duration(seconds: 2),
        //   animationDuration: Duration(milliseconds: 500),
        // );
      }
      // log(error.message);
      rethrow;
    } catch (e) {
      // log(_.toString());
      throw 'error is ${e.toString()}';
    }
  }

  Future<int> makeGetRequest(String fileName) async {
    int status = 500;
    final String url =
        'https://nfaa7msxkb.execute-api.us-east-1.amazonaws.com/dev/students?objectKey=$fileName';

    print('Get API: $url');

    try {
      final response = await Dio().get(url);
      print(response);
      if (response.statusCode == 200) {
        // Image uploaded successfully.
        print('Validated successfully!');

        /// todo success dialog
        // showCustomDialog(context, "Done");

        // Make a GET request with the generated name
      }

      status = response.statusCode!;
      return status;
      // Handle the response from the GET request as needed.
    } on DioException catch (error) {
      status = error.response?.statusCode ?? 500;
      print(error.message);
      return status;

      rethrow;
    } catch (e) {
      status = 500;
      print(e.toString());
      return status;
      // Handle other exceptions
      print(e.toString());

      throw 'error is ${e.toString()}';
    }
  }

  Future<XFile?> capturePhoto() async {
    Get.dialog(const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        )));
    if (cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await cameraController.setFlashMode(FlashMode.off); //optional
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future<int> onTakePhotoPressed() async {
    final xFile = await capturePhoto();
    if (xFile != null) {
      if (xFile.path.isNotEmpty) {
        picture = xFile;
        File file = File(picture.path);
        return registerBusVisitorFace(file: file);

        print("pathh =========${picture.path}");
      }
      return 501;
    }
    return 502;
  }
  Future<int> takePhotoFromCamera(ImageSource imageSource) async {
    setLoading(true); // Set loading state to true before processing

    try {
      final xFile = await _imagePicker.pickImage(
        source: imageSource,
      );

      if (xFile != null) {
        if (xFile.path.isNotEmpty) {
          picture = xFile;
          File file = File(picture.path);
          return registerBusVisitorFace(file: file);
        }
        print("pathh =========${picture.path}");
      }
      return 505;
    } catch (e) {
      print("Error while picking image from camera: $e");
      return 504; // Return null in case of errors
    }
    finally {
      setLoading(false); // Set loading state to false after processing
    }
  }

  @override
  void onClose() {
    initializeControllerFuture();
    super.onClose();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
