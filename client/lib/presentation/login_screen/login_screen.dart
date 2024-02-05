import 'package:client/core/app_export.dart';
import 'package:client/presentation/model/token_model.dart';
import 'package:client/widgets/custom_elevated_button.dart';
import 'package:client/widgets/custom_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

final Dio dio = Dio();

TokenModel GlobalModel = TokenModel(token: '');

class MyCustomException implements Exception {
  final String message;

  MyCustomException(this.message);
}

get baseURL {
  String baseUrl = "";
  if (Platform.isAndroid) {
    // Android
    baseUrl = "http://10.0.2.2:8080/api";
  } else if (Platform.isIOS) {
    // iOS
    baseUrl = "http://localhost:8080/api";
  }
  return baseUrl;
}

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  String formatToken(String originalToken) {
    return originalToken;
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> sentLogin(BuildContext context) async {
    try {
      final response = await dio.post(
        '$baseURL/surveyor/loginSurveyor',
        data: {
          "email": emailController.text,
          "PassWord": passwordController.text,
        },
        options: Options(
          responseType: ResponseType.json,
          validateStatus: (statusCode) {
            return statusCode == null ||
                (statusCode >= 200 && statusCode < 300);
          },
        ),
      );

      print(response.data['message']);

      if (response.data['message'] == 'Password is incorrect') {
        print('Password is incorrect');
        // Handle incorrect password case, display a message to the user, etc.
      } else {
        TokenModel tokenModel = TokenModel.fromMap(response.data);
        GlobalModel = TokenModel(token: formatToken(tokenModel.token));
        Navigator.pushNamed(context, AppRoutes.homePage);
        final SharedPreferences prefsToken =
            await SharedPreferences.getInstance();
        prefsToken.setString('token', GlobalModel.token);
      }
    } catch (e) {
      print("Error: $e");
      // Handle Dio-specific errors or other exceptions
      throw Exception("Error on server");
    }
  }

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
                      _buildEmailSection(context),
                      SizedBox(height: 29.v),
                      _buildPasswordSection(context),
                      SizedBox(height: 34.v),
                      CustomElevatedButton(
                        height: 53.v,
                        width: 195.h,
                        text: "Sign in",
                        buttonStyle: CustomButtonStyles.fillBlue,
                        buttonTextStyle: CustomTextStyles.titleLargeWhiteA700_1,
                        onPressed: () {
                          sentLogin(context);
                          ;
                        },
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

  Widget _buildEmailSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 69.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: Text(
              "Email",
              style: theme.textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 3.v),
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: CustomTextFormField(
              textStyle: const TextStyle(color: Colors.black),
              controller: emailController,
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
              textStyle: const TextStyle(color: Colors.black),
              textInputAction: TextInputAction.done,
              obscureText: true,
            ),
          ),
        ],
      ),
    );
  }
}
