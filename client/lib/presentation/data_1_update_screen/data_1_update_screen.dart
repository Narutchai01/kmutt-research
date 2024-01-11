import 'package:client/core/app_export.dart';
// import 'package:app_design/presentation/data_2_update_page/data_2_update_page.dart';
import 'package:client/presentation/profile_update_page/profile_update_page.dart';
import 'package:client/presentation/search_update_page/search_update_page.dart';
import 'package:client/presentation/user_profile_update_page/user_profile_update_page.dart';
import 'package:client/widgets/custom_bottom_bar.dart';
import 'package:client/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:client/presentation/status_update_screen/status_update_screen.dart';

// ignore_for_file: must_be_immutable
class Data1UpdateScreen extends StatelessWidget {
  Data1UpdateScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                                                "50/100 m.1 Bangkaw Nakhon Chaisi Nakhon Pathom 73120",
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
                                            "BMW i4",
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
                                            "POL-001",
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
                                            "Auto Insurance",
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
                                            "1-1-2023/31-12-2023",
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
                                      CustomElevatedButton(
                                          width: 150.h,
                                          text: "New case",
                                          buttonTextStyle: CustomTextStyles
                                              .titleMediumBluegray50,
                                          onPressed: () {
                                            onTapNewCase(context);
                                          }),
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

  /// Section Widget
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
              child: Text("Anthony Edward Stark\nYC7I AWH",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.bodyLargeNunitoBlack900_1))
        ]));
  }

  /// Section Widget
  Widget _buildContactColumn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 0.h),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center the text horizontally
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
                  "test@gmail.com",
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
                  "087-160-3130",
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
                  "Stark0086",
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

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.profileUpdatePage;
      case BottomBarEnum.Circumsearch:
        return AppRoutes.searchUpdatePage;
      case BottomBarEnum.Fluenttasklist20filled:
        return AppRoutes.statusUpdateScreen;
      case BottomBarEnum.Lock:
        return AppRoutes.userProfileUpdatePage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.profileUpdatePage:
        return ProfileUpdatePage();
      case AppRoutes.searchUpdatePage:
        return SearchUpdatePage();
      case AppRoutes.statusUpdateScreen:
        return StatusUpdateScreen();
      case AppRoutes.userProfileUpdatePage:
        return UserProfileUpdatePage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the cameraUpdateScreen when the action is triggered.
  onTapNewCase(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.cameraUpdateScreen);
  }
}
