import 'package:client/core/app_export.dart';
import 'package:client/presentation/Changepassword/changepassword.dart';
import 'package:flutter/material.dart';
import 'package:client/presentation/model/User_model.dart';
import 'package:dio/dio.dart';
import 'package:client/presentation/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

StringModel UserProfile = StringModel(
  First_name: '',
  Last_name: '',
  SurveyorID: '',
  Birth_date: '',
  Image: '',
  Email: '',
  Phone_number: '',
  Password: '',
);
get baseURL {
  String baseUrl = "https://kmutt-api.onrender.com/api";
  return baseUrl;
}

// get baseURL {
//   String baseUrl = "http://10.0.2.2:8080/api";
//   return baseUrl;
// }

// ignore_for_file: must_be_immutable
class UserProfileUpdatePage extends StatefulWidget {
  @override
  State<UserProfileUpdatePage> createState() => _UserProfileUpdatePageState();
}

class _UserProfileUpdatePageState extends State<UserProfileUpdatePage> {
  final dio = Dio();

  Future<StringModel> getProfileData() async {
    final response = await dio.get(
      '$baseURL/surveyor/findSurveyorByID/${GlobalModel.token}',
    );

    return StringModel.fromMap(response.data[0]);
  }

  String extractDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  Future<Null> SignOut() async {
    final SharedPreferences prefsToken = await SharedPreferences.getInstance();
    prefsToken.remove('token');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        body: FutureBuilder<StringModel>(
          future: getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              UserProfile = snapshot.data!;
              return Container(
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
                              "${changeFormat(UserProfile.SurveyorID)}",
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
                              extractDate(UserProfile.Birth_date),
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
                              "${UserProfile.Email}",
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
                              "${UserProfile.Phone_number}",
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
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePassword(),
                                  ),
                                );
                              },
                              child: Text(
                                "Edit password",
                                style: theme.textTheme.titleLarge,
                              ),
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
                          Icon(
                            Icons.logout,
                            size: 35,
                            color: Color.fromRGBO(92, 135, 213, 1),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 27.h,
                              top: 6.v,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );

                                SignOut();
                              },
                              child: Text(
                                "Logout",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              );
            }
          },
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
            imagePath: UserProfile.Image,
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
                right: 30.h,
                bottom: 10.v,
              ),
              child: Text(
                "${UserProfile.First_name} ${UserProfile.Last_name}",
                style: theme.textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String changeFormat(String surveyorID) {
  String formattedNumber = surveyorID.toString().padLeft(5, '0');
  return "${formattedNumber}";
}
