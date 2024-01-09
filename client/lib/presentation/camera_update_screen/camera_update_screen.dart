import 'package:client/core/app_export.dart';
import 'package:flutter/material.dart';

class CameraUpdateScreen extends StatelessWidget {
  const CameraUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                // This container can represent the camera viewfinder or viewport
                color: Colors.black, // Example color, adjust as needed
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCustomImageView(
                      imagePath: ImageConstant.imgTelevision,
                      onTap: () => onTapImgTelevision(context),
                    ),
                    _buildCustomImageView(
                      imagePath: ImageConstant.imgCamera,
                    ),
                  ],
                ),
              ),
            ),
            // Include _buildCameraUpdateRow at the top if necessary
          ],
        ),
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
      ),
    );
  }

  onTapImgTelevision(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.imagepickerUpdateScreen);
  }

  // Include _buildCameraUpdateRow and other methods if necessary
}
