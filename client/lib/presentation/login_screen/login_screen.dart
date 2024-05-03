import 'dart:async';

import 'package:client/core/app_export.dart';
import 'package:client/presentation/Home_page/hom_page.dart';
import 'package:client/presentation/model/token_model.dart';

import 'package:client/widgets/custom_text_form_field.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

final Dio dio = Dio(BaseOptions(
  connectTimeout: Duration(
      milliseconds:
          10000), // Set the connection timeout to 10 seconds (adjust as needed)
));

TokenModel GlobalModel = TokenModel(token: '');

class MyCustomException implements Exception {
  final String message;

  MyCustomException(this.message);
}

get baseURL {
  String baseUrl = "https://kmutt-api.onrender.com/api";
  return baseUrl;
}

// get baseURL {
//   String baseUrl = "http://192.168.40.46:8080/api";
//   return baseUrl;
// }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String formatToken(String originalToken) {
    return originalToken;
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  Future<Null> checkToken() async {
    final SharedPreferences prefsToken = await SharedPreferences.getInstance();
    final String? token = prefsToken.getString('token');
    if (token != null) {
      GlobalModel = TokenModel(token: formatToken(token));
      Navigator.pushNamed(context, AppRoutes.homePage);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(index: 0),
      ));
    }
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
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Oops...',
          text: 'Email or Password is incorrect',
          loopAnimation: false,
        );
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
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Email or Password is incorrect',
        loopAnimation: false,
      );
    }
  }

  @override
  Widget build(BuildContext) {
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

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set the desired border radius value
                          ),
                          fixedSize: const Size(195, 53),
                        ),
                        onPressed: () {
                          sentLogin(context);
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        ),
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
