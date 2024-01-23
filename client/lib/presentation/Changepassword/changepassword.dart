import 'package:client/core/app_export.dart';
import 'package:client/presentation/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:client/widgets/custom_elevated_button.dart';
import 'package:client/theme/custom_button_style.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final dio = Dio();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void ChangePasswordApi() async {
    try {
      final response = await dio.post(
        'http://10.0.2.2:8080/api/surveyor/changePassWord/${GlobalModel.token}',
        data: {
          "oldPassword": currentPasswordController.text,
          "newPassword": newPasswordController.text,
        },
      );
      print(response);
    } catch (e) {
      print(e);
    }
  }

  void CheckPassword() {
    if (newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      print('Please fill in all fields');
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Please fill in all fields',
        loopAnimation: false,
      );
      return;
    }

    if (newPasswordController.text == confirmNewPasswordController.text) {
      ChangePasswordApi();

      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: 'Changepassword completed successfully!',
        autoCloseDuration: const Duration(seconds: 2),
      );
    } else {
      print('Password is incorrect');
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Password is incorrect',
        loopAnimation: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Changepassword"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: confirmNewPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
              height: 53,
              width: 195,
              text: "Change Password",
              buttonStyle: CustomButtonStyles.fillBlue,
              buttonTextStyle: CustomTextStyles.titleLargeWhiteA700_1,
              onPressed: () {
                print(GlobalModel.token);
                print(newPasswordController.text);
                print(confirmNewPasswordController.text);
                CheckPassword();
                ;
              },
            ),
          ],
        ),
      ),
    );
  }
}
