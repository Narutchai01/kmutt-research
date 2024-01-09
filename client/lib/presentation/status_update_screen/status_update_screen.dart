import 'package:client/core/app_export.dart';
import 'package:client/presentation/data_2_update_page/data_2_update_page.dart';
import 'package:client/presentation/profile_update_page/profile_update_page.dart';
import 'package:client/presentation/search_update_page/search_update_page.dart';
import 'package:client/presentation/user_profile_update_page/user_profile_update_page.dart';
import 'package:client/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class StatusUpdateScreen extends StatelessWidget {
  StatusUpdateScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 0.34),
              colors: [
                appTheme.blue900,
                appTheme.blue900,
              ],
            ),
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(height: 10.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // _buildHeadSection(context),
                        SizedBox(height: 31.v),
                        _buildSeventyNineSection(context),
                        SizedBox(height: 8.v),
                        Container(
                          height: 900.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.h,
                            vertical: 19.v,
                          ),
                          decoration: AppDecoration.outlineBlack9001.copyWith(
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
                              _buildSeventyTwoSection(context),
                              SizedBox(height: 16.v),
                              _buildThirtyThreeSection(context),
                              SizedBox(height: 16.v),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: _buildBottomBarSection(context),
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

  /// Section Widget
  Widget _buildSeventyNineSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 29.h,
        right: 20.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Status",
            style: theme.textTheme.displayMedium,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgSearch,
            height: 34.adaptSize,
            width: 34.adaptSize,
            margin: EdgeInsets.only(
              top: 11.v,
              bottom: 9.v,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  // Widget _buildSeventyTwoSection(BuildContext context) {
  //   return SizedBox(
  //     height: 68.v,
  //     width: 398.h,
  //     child: Stack(
  //       alignment: Alignment.centerLeft,
  //       children: [
  //         Align(
  //           alignment: Alignment.center,
  //           child: Container(
  //             padding: EdgeInsets.symmetric(
  //               horizontal: 48.h,
  //               vertical: 18.v,
  //             ),
  //             decoration: AppDecoration.gradientBlueToBlue900.copyWith(
  //               borderRadius: BorderRadiusStyle.roundedBorder10,
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 SizedBox(height: 3.v),
  //                 Text(
  //                   "Status",
  //                   style: CustomTextStyles.titleLargeWhiteA700,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: Padding(
  //             padding: EdgeInsets.only(left: 34.h),
  //             child: Row(
  //               children: [
  //                 Text(
  //                   "Date",
  //                   style: CustomTextStyles.titleLargeWhiteA700,
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(left: 77.h),
  //                   child: Text(
  //                     "Car ID",
  //                     style: CustomTextStyles.titleLargeWhiteA700,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildSeventyTwoSection(BuildContext context) {
    return Container(
      height: 68.v,
      width: MediaQuery.of(context).size.width -
          16.h, // Adjust width according to screen size
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 18.v),
      decoration: AppDecoration.gradientBlueToBlue900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Date",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          Text(
            "Car ID",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          Text(
            "Status",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
            // Keep "Status" text slightly larger
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtyThreeSection(BuildContext context) {
  return GestureDetector(
    onTap: () => onTapCases(context),
    child: Container(
      height: 68.v,
      width: MediaQuery.of(context).size.width - 16.h,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 18.v),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "1-1-2021",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Text(
            "YCI-1234",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Text(
            "o Success",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
}
void onTapCases(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Data2UpdatePage()),
  );
}
  /// Section Widget
  // Widget _buildBottomBarSection(BuildContext context) {
  //   return CustomBottomBar(
  //     onChanged: (BottomBarEnum type) {
  //       Navigator.pushNamed(
  //           navigatorKey.currentContext!, getCurrentRoute(type));
  //     },
  //   );
  // }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.profileUpdatePage;
      case BottomBarEnum.Circumsearch:
        return AppRoutes.searchUpdatePage;
      case BottomBarEnum.Fluenttasklist20filled:
        return AppRoutes.data2UpdatePage;
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
      case AppRoutes.data2UpdatePage:
        return Data2UpdatePage();
      case AppRoutes.userProfileUpdatePage:
        return UserProfileUpdatePage();
      default:
        return DefaultWidget();
    }
  }
}


