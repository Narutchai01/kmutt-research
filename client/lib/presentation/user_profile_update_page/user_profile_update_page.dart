import 'package:client/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class UserProfileUpdatePage extends StatelessWidget {
  const UserProfileUpdatePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileStack(context),
              SizedBox(height: 41.v),
              Padding(
                padding: EdgeInsets.only(left: 41.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLockIndigo300,
                      height: 23.v,
                      width: 18.h,
                      margin: EdgeInsets.only(
                        top: 5.v,
                        bottom: 6.v,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 31.h),
                      child: Text(
                        "Poomthai ",
                        style: theme.textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 46.v),
              Padding(
                padding: EdgeInsets.only(left: 41.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgThumbsUpIndigo300,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                      margin: EdgeInsets.only(
                        top: 6.v,
                        bottom: 8.v,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.h),
                      child: Text(
                        "10-10-2000",
                        style: theme.textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.v),
              Padding(
                padding: EdgeInsets.only(left: 42.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLockIndigo30020x23,
                      height: 20.v,
                      width: 23.h,
                      margin: EdgeInsets.only(bottom: 8.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28.h),
                      child: Text(
                        "test@gmail.com",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 49.v),
              Padding(
                padding: EdgeInsets.only(left: 42.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgCall,
                      height: 26.v,
                      width: 23.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28.h),
                      child: Text(
                        "087-1234567",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 47.v),
              Padding(
                padding: EdgeInsets.only(left: 42.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLocation,
                      height: 32.v,
                      width: 25.h,
                      margin: EdgeInsets.only(bottom: 1.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 27.h,
                        top: 6.v,
                      ),
                      child: Text(
                        "Edit password",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProfileStack(BuildContext context) {
    return SizedBox(
      height: 246.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 19.v,
              ),
              decoration: AppDecoration.fillBlue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.h),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.v),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.v),
                  Padding(
                    padding: EdgeInsets.only(left: 15.h),
                    child: Text(
                      "Profile",
                      style: theme.textTheme.displayMedium,
                    ),
                  ),
                  SizedBox(height: 59.v),
                ],
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgEllipse33119x122,
            height: 119.v,
            width: 122.h,
            radius: BorderRadius.circular(
              61.h,
            ),
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 41.h),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: 78.h,
                bottom: 2.v,
              ),
              child: Text(
                "Poom Poomthai",
                style: theme.textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
