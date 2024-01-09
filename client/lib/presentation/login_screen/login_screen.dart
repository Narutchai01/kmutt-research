import 'package:client/core/app_export.dart';
import 'package:client/widgets/custom_elevated_button.dart';
import 'package:client/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 19.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // _buildRowWithImages(context),
                      SizedBox(height: 93.v),
                      CustomImageView(
                        imagePath: ImageConstant.imgAcsLogo2,
                        height: 173.v,
                        width: 244.h,
                      ),
                      SizedBox(height: 22.v),
                      Text(
                        "Hello",
                        style: CustomTextStyles.displayMediumBlack900,
                      ),
                      SizedBox(height: 1.v),
                      Text(
                        "Sign in your account",
                        style: theme.textTheme.titleLarge,
                      ),
                      SizedBox(height: 22.v),
                      _buildUsernameSection(context),
                      SizedBox(height: 29.v),
                      _buildPasswordSection(context),
                      SizedBox(height: 34.v),
                      CustomElevatedButton(
                        height: 53.v,
                        width: 195.h,
                        text: "Sign in",
                        buttonStyle: CustomButtonStyles.fillBlue,
                        buttonTextStyle: CustomTextStyles.titleLargeWhiteA700_1,
                      ),
                      SizedBox(height: 273.v),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  // Widget _buildRowWithImages(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       left: 25.h,
  //       right: 20.h,
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.only(top: 3.v),
  //           child: Text(
  //             "15:05 Fri 6 Oct",
  //             style: CustomTextStyles.bodyLargeBlack900,
  //           ),
  //         ),
  //         Spacer(),
  //         CustomImageView(
  //           imagePath: ImageConstant.imgSettings,
  //           height: 19.v,
  //           width: 27.h,
  //           margin: EdgeInsets.only(bottom: 4.v),
  //         ),
  //         CustomImageView(
  //           imagePath: ImageConstant.imgSettingsBlack900,
  //           height: 18.v,
  //           width: 25.h,
  //           margin: EdgeInsets.only(
  //             left: 7.h,
  //             bottom: 4.v,
  //           ),
  //         ),
  //         CustomImageView(
  //           imagePath: ImageConstant.imgVectorBlack900,
  //           height: 19.v,
  //           width: 39.h,
  //           margin: EdgeInsets.only(
  //             left: 7.h,
  //             bottom: 3.v,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildUsernameSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 69.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: Text(
              "Username",
              style: theme.textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 3.v),
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: CustomTextFormField(
              textStyle: TextStyle(
                color: Colors.black
              ),
              controller: userNameController,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 69.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Password",
              style: theme.textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 3.v),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: CustomTextFormField(
              controller: passwordController,
              textStyle: TextStyle(
                color: Colors.black
              ),
              textInputAction: TextInputAction.done,
              obscureText: true,
            ),
          ),
        ],
      ),
    );
  }
}