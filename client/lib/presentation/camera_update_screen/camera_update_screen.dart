// import 'package:client/core/app_export.dart';
// import 'package:flutter/material.dart';

// class CameraUpdateScreen extends StatelessWidget {
//   const CameraUpdateScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Positioned.fill(
//               child: Container(
//                 // This container can represent the camera viewfinder or viewport
//                 color: Colors.black, // Example color, adjust as needed
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildCustomImageView(
//                       imagePath: ImageConstant.imgTelevision,
//                       onTap: () => onTapImgTelevision(context),
//                     ),
//                     _buildCustomImageView(
//                       imagePath: ImageConstant.imgCamera,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Include _buildCameraUpdateRow at the top if necessary
//           ],
//         ),
//       ),
//     );
//   }

// Widget _buildCustomImageView(
//     {required String imagePath, VoidCallback? onTap}) {
//   return GestureDetector(
//     onTap: onTap,
//     child: CustomImageView(
//       imagePath: imagePath,
//       height: 59.v,
//       width: 59.h,
//     ),
//   );
// }

//   onTapImgTelevision(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.imagepickerUpdateScreen);
//   }

//   // Include _buildCameraUpdateRow and other methods if necessary
// }
import 'package:camera/camera.dart';
import 'package:client/presentation/camera_update_screen/camera_previwe.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:client/core/app_export.dart';

class CameraUpdateScreen extends StatefulWidget {
  const CameraUpdateScreen({Key? key});

  @override
  State<CameraUpdateScreen> createState() => _CameraUpdateScreenState();
}

class _CameraUpdateScreenState extends State<CameraUpdateScreen> {
  late CameraController _controller;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.max);

    // Initialize the camera controller
    await _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    try {
      final imagePicker = ImagePicker();
      final imageFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePreview(imageFile),
          ),
        );
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  _buildCustomImageView(
                    imagePath: ImageConstant.imgTelevision,
                    onTap: () => _pickImage(),
                  ),
                  _buildCustomImageView(
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
                      } on CameraException catch (e) {
                        debugPrint("Error while taking picture");
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Center(
          //       child: Container(
          //         margin: EdgeInsets.all(20.0),
          //         child: MaterialButton(
          //           onPressed: () async {
          //             if (!_controller.value.isInitialized) {
          //               return null;
          //             }
          //             if (_controller.value.isTakingPicture) {
          //               return null;
          //             }
          //             try {
          //               await _controller.setFlashMode(FlashMode.auto);
          //               XFile file = await _controller.takePicture();
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => ImagePreview(file),
          //                 ),
          //               );
          //             } on CameraException catch (e) {
          //               debugPrint("Error while taking picture");
          //               return null;
          //             }
          //           },
          //           color: Colors.white,
          //           child: Text("Take a picture"),
          //         ),
          //       ),
          //     ),
          //     Center(
          //       child: Container(
          //         margin: EdgeInsets.all(20.0),
          //         child: MaterialButton(

          //           onPressed: _pickImage,
          //           color: Colors.white,
          //           child: Text("Pick Image from Gallery"),
          //         ),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _buildCustomImageView(
      {required String imagePath, VoidCallback? onTap}) {
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
