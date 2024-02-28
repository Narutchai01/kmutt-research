import 'package:camera/camera.dart';
import 'package:client/presentation/camera_update_screen/camera_previwe.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:client/core/app_export.dart';
import 'package:client/presentation/imagepicker_confirm/imagepicker_confirm.dart';

class CameraUpdateScreen extends StatefulWidget {
  const CameraUpdateScreen({Key? key});

  @override
  State<CameraUpdateScreen> createState() => _CameraUpdateScreenState();
}

class _CameraUpdateScreenState extends State<CameraUpdateScreen> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool _isCameraInitialized = false;
  List<XFile> selectedImages = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      _controller = CameraController(cameras[0], ResolutionPreset.max);

      // Initialize the camera controller
      await _controller.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    try {
      final imagePicker = ImagePicker();
      final List<XFile>? imageFiles = await imagePicker.pickMultiImage();
      if (imageFiles != null && imageFiles.isNotEmpty) {
        // Navigate to ImagePickerConfirm and clear the navigation stack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePickerConfirm(imageFiles),
          ),
          (route) => true,
        );
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera")),
      body: _isCameraInitialized
          ? Stack(
              children: [
                Container(
                  height: double.infinity,
                  child: CameraPreview(_controller),
                ),
                Positioned(
                  bottom: 0,
                  left: -125,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        picimg_btn(
                          imagePath: ImageConstant.imgTelevision,
                          onTap: () => _pickImage(),
                        ),
                        take_img_btn(
                          imagePath: ImageConstant.imgCamera,
                          onTap: () async {
                            if (!_controller.value.isInitialized) {
                              return null;
                            }
                            if (_controller.value.isTakingPicture) {
                              return null;
                            }
                            try {
                              await _controller.setFlashMode(FlashMode.auto);
                              XFile file = await _controller.takePicture();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImagePreview(file),
                                ),
                              );
                            } on CameraException {
                              debugPrint("Error while taking picture");
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget picimg_btn({required String imagePath, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CustomImageView(
        imagePath: imagePath,
        height: 59.v,
        width: 59.h,
        color: Color(0xFFE6E6E6),
      ),
    );
  }

  Widget take_img_btn({required String imagePath, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CustomImageView(
        imagePath: imagePath,
        height: 59.v,
        width: 59.h,
        color: Color(0xFFE6E6E6),
      ),
    );
  }
}
