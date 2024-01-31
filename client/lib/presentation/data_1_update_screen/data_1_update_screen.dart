import 'package:client/core/app_export.dart';
import 'package:client/presentation/camera_update_screen/camera_update_screen.dart';
import 'package:client/presentation/profile_update_container_screen/profile_update_container_screen.dart';
// import 'package:app_design/presentation/data_2_update_page/data_2_update_page.dart';

import 'package:client/presentation/search_update_page/search_update_page.dart';

import 'package:client/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class Data1UpdateScreen extends StatefulWidget {
  const Data1UpdateScreen({super.key});

  @override
  State<Data1UpdateScreen> createState() => _Data1UpdateScreenState();
}

class _Data1UpdateScreenState extends State<Data1UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    print('Test 2 : ${customer.CarID}');
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(0.5, 0),
                  end: Alignment(0.5, 0.34),
                  colors: [appTheme.blue900, appTheme.blue900])),
          child: SizedBox(
              width: double.maxFinite,
              child: Column(children: [
                SizedBox(height: 5.v),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  // _buildHeadRow(context),
                  SizedBox(height: 22.v),
                  _buildUserRow(context),
                  SizedBox(height: 36.v),
                  SizedBox(
                      height: 910.v,
                      width: double.maxFinite,
                      child: Stack(alignment: Alignment.topCenter, children: [
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 36.h, vertical: 236.v),
                                decoration: AppDecoration.outlineBlack900
                                    .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder20),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Address :",
                                            style: CustomTextStyles
                                                .bodyLargeNunitoBlack900,
                                            textAlign: TextAlign.left,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                "${customer.Address}",
                                                style:
                                                    theme.textTheme.titleMedium,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Model :",
                                            style: CustomTextStyles
                                                .bodyLargeNunitoBlack900,
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${customer.Model}",
                                            style: theme.textTheme.titleMedium,
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Color :",
                                            style: CustomTextStyles
                                                .bodyLargeNunitoBlack900,
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "White",
                                            style: theme.textTheme.titleMedium,
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Policy Document Number :",
                                            style: CustomTextStyles
                                                .bodyLargeNunitoBlack900,
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${customer.Policy_number}",
                                            style: theme.textTheme.titleMedium,
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Type of Insurance :",
                                            style: CustomTextStyles
                                                .bodyLargeNunitoBlack900,
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${customer.Policy_type}",
                                            style: theme.textTheme.titleMedium,
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Start /End :",
                                            style: CustomTextStyles
                                                .bodyLargeNunitoBlack900,
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${extractDate(customer.Start_date)} / ${extractDate(customer.End_date)}",
                                            style: theme.textTheme.titleMedium,
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 31.v),
                                      Divider(color: appTheme.blueGray100),
                                      SizedBox(height: 24.v),
                                      _buildContactColumn(context),
                                      SizedBox(height: 33.v),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 0.h),
                                        child: CustomElevatedButton(
                                            width: 150.h,
                                            text: "New case",
                                            buttonTextStyle: CustomTextStyles
                                                .titleMediumBluegray50,
                                            onPressed: () {
                                              getPageroute(
                                                  AppRoutes.cameraUpdateScreen);
                                              gocamrea(context);
                                            }),
                                      ),
                                      SizedBox(height: 4.v)
                                    ]))),
                        CustomImageView(
                            imagePath: ImageConstant.imgImage7,
                            height: 209.v,
                            width: 430.h,
                            alignment: Alignment.topCenter)
                      ]))
                ])))
              ]))),
    ));
  }

  Widget _buildUserRow(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 35.h, vertical: 22.v),
        decoration: AppDecoration.outlineBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder20),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          CustomImageView(
              imagePath: ImageConstant.imgEllipse33,
              height: 72.v,
              width: 74.h,
              radius: BorderRadius.circular(37.h),
              margin: EdgeInsets.only(top: 1.v)),
          Container(
              width: 165.h,
              margin: EdgeInsets.only(left: 20.h, top: 21.v, bottom: 8.v),
              child: Text(
                  "${customer.First_name} ${customer.Last_name}\n${customer.CarID}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.bodyLargeNunitoBlack900_1))
        ]));
  }

  Widget _buildContactColumn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 0.h),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Contact",
              style: CustomTextStyles.titleLargeBold,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email :",
                  style: CustomTextStyles.bodyLargeNunitoBlack900,
                  textAlign: TextAlign.left,
                ),
                Text(
                  "${customer.Email}",
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone number :",
                  style: CustomTextStyles.bodyLargeNunitoBlack900,
                  textAlign: TextAlign.left,
                ),
                Text(
                  "${customer.Phone_number}",
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Line ID :",
                  style: CustomTextStyles.bodyLargeNunitoBlack900,
                  textAlign: TextAlign.left,
                ),
                Text(
                  "${customer.Line}",
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // void _navigateToCamera(BuildContext context) {
  //   getPageroute(AppRoutes.cameraUpdateScreen);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => CameraUpdateScreen()),
  //   );
  // }

  String extractDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }
}
