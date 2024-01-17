import 'package:client/core/app_export.dart';
import 'package:client/presentation/status_update_screen/status_update_screen.dart';
import 'package:client/widgets/custom_image.dart';
import 'package:client/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:client/presentation/login_screen/login_screen.dart';
import 'package:client/presentation/profile_update_page/User_model.dart';
// ignore_for_file: must_be_immutable

StringModel Profile1 = StringModel(
  First_name: '',
  Last_name: '',
  SurveyorID: '',
  Birth_date: '',
  Image: '',
  Email: '',
  Phone_number: '',
  Password: '',
);

class ProfileUpdatePage extends StatelessWidget {
  ProfileUpdatePage({Key? key})
      : super(
          key: key,
        );
  final dio = Dio();
  var data;

  void GetSurveryor(BuildContext context) async {
    final response = await dio.get(
      'http://10.0.2.2:8080/api/surveyor/findSurveyorByID/${GlobalModel.token}',
    );

    // var data = response.data[0];
    print(response.data[0]);
    Profile1 = StringModel.fromMap(response.data[0]);
  }

  TextEditingController editTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GetSurveryor(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.blue900,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillBlue,
          child: Column(
            children: [
              SizedBox(height: 10.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 43.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 105.v,
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: 54.h),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 31.v,
                                  width: 110.h,
                                  margin: EdgeInsets.only(
                                    right: 155.h,
                                    bottom: 19.v,
                                  ),
                                  decoration: BoxDecoration(
                                    color: appTheme.whiteA700,
                                    borderRadius: BorderRadius.circular(
                                      10.h,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.network(
                                          Profile1.Image,
                                          height: 80.0,
                                          width: 81.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 20.v,
                                        bottom: 15.v,
                                        left: 30.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${Profile1.First_name} ${Profile1.Last_name}',
                                            style: CustomTextStyles
                                                .titleLargeWhiteA700,
                                          ),
                                          SizedBox(height: 7.v),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.h),
                                            child: Text(
                                              '${Profile1.SurveyorID}',
                                              style: CustomTextStyles
                                                  .titleLargeBlue900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 52.v),
                      Container(
                        height: 800.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 34.h,
                          vertical: 10.v,
                        ),
                        decoration: AppDecoration.fillWhiteA.copyWith(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgMdiGraphLine,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize,
                                    margin: EdgeInsets.only(
                                      top: 8.v,
                                      bottom: 4.v,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.h),
                                    child: Text(
                                      "Statistics",
                                      style: theme.textTheme.headlineLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 6.v),
                            Container(
                              height: 160.v,
                              width: 361.h,
                              decoration: BoxDecoration(
                                  color: appTheme.blue100,
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(10.h),
                                      left: Radius.circular(10.h))),
                            ),
                            SizedBox(height: 38.v),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgThumbsUp,
                                    height: 20.v,
                                    width: 18.h,
                                    margin: EdgeInsets.only(
                                      top: 2.v,
                                      bottom: 8.v,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.h),
                                    child: Text(
                                      "Today",
                                      style:
                                          CustomTextStyles.headlineSmallInter,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.v),
                            Container(
                              height: 70.v,
                              width: 361.h,
                              decoration: BoxDecoration(
                                color: appTheme.blue100,
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(10.h),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(10.h),
                                ),
                                child: LinearProgressIndicator(
                                  value: 0.03,
                                  backgroundColor: appTheme.blue100,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    appTheme.blue900,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.v),
                            Container(
                              height: 70.v,
                              width: 361.h,
                              decoration: BoxDecoration(
                                color: appTheme.blue100,
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10.h),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10.h),
                                ),
                                child: LinearProgressIndicator(
                                  value: 0.97,
                                  backgroundColor: appTheme.blue900,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    appTheme.blue100,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.v),
                          ],
                        ),
                      ),
                      // SizedBox(height: 48.v),
                      // Container(
                      //   height: 68.v,
                      //   width: double.maxFinite,
                      //   decoration: BoxDecoration(
                      //     color: appTheme.whiteA700,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: appTheme.black900.withOpacity(0.25),
                      //         spreadRadius: 2.h,
                      //         blurRadius: 2.h,
                      //         offset: Offset(
                      //           0,
                      //           4,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
  // Widget _buildHeadSection(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       left: 25.h,
  //       right: 20.h,
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.only(
  //             top: 13.v,
  //             bottom: 5.v,
  //           ),
  //           child: Text(
  //             "15:05 Fri 6 Oct",
  //             style: theme.textTheme.bodyLarge,
  //           ),
  //         ),
  //         Spacer(),
  //         CustomImageView(
  //           imagePath: ImageConstant.imgVector,
  //           height: 19.v,
  //           width: 27.h,
  //           margin: EdgeInsets.symmetric(vertical: 10.v),
  //         ),
  //         CustomImageView(
  //           imagePath: ImageConstant.imgSettingsWhiteA700,
  //           height: 18.v,
  //           width: 25.h,
  //           margin: EdgeInsets.only(
  //             left: 7.h,
  //             top: 10.v,
  //             bottom: 10.v,
  //           ),
  //         ),
  //         CustomImageView(
  //           imagePath: ImageConstant.imgBiBattery,
  //           height: 39.adaptSize,
  //           width: 39.adaptSize,
  //           margin: EdgeInsets.only(left: 7.h),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
