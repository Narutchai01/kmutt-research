import 'package:client/core/app_export.dart';
import 'package:client/presentation/data_2_update_page/data_2_update_page.dart';
import 'package:client/presentation/profile_update_page/profile_update_page.dart';
import 'package:client/presentation/search_update_page/search_update_page.dart';
import 'package:client/presentation/user_profile_update_page/user_profile_update_page.dart';
import 'package:client/widgets/custom_bottom_bar.dart';
import 'package:client/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchTwoScreen extends StatelessWidget {
  SearchTwoScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

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
                SizedBox(height: 18.v),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // _buildSearchTwoRow(context),
                        SizedBox(height: 40.v),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 44.h,
                            right: 43.h,
                          ),
                          child: CustomSearchView(
                            controller: searchController,
                            hintText: "AB-1234",
                          ),
                        ),
                        SizedBox(height: 34.v),
                        SizedBox(
                          height: 775.v,
                          width: double.maxFinite,
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.h,
                                    vertical: 27.v,
                                  ),
                                  decoration: AppDecoration.fillWhiteA.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder20,
                                  ),
                                  child: Container(
                                    height: 122.v,
                                    width: 387.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.gray100,
                                      borderRadius: BorderRadius.circular(
                                        20.h,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: appTheme.black900
                                              .withOpacity(0.25),
                                          spreadRadius: 2.h,
                                          blurRadius: 2.h,
                                          offset: Offset(
                                            0,
                                            1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 44.h,
                                    top: 52.v,
                                  ),
                                  child: Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgEllipse33,
                                        height: 72.v,
                                        width: 74.h,
                                        radius: BorderRadius.circular(
                                          37.h,
                                        ),
                                      ),
                                      Container(
                                        width: 163.h,
                                        margin: EdgeInsets.only(
                                          left: 20.h,
                                          top: 20.v,
                                          bottom: 8.v,
                                        ),
                                        child: Text(
                                          "Anthony Edward Stark\nAB-1234",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyles
                                              .bodyLargeNunitoBlack900_1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  // /// Section Widget
  // Widget _buildSearchTwoRow(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 20.h),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Expanded(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.only(top: 3.v),
  //                 child: Text(
  //                   "15:05 Fri 6 Oct",
  //                   style: theme.textTheme.bodyLarge,
  //                 ),
  //               ),
  //               Spacer(),
  //               CustomImageView(
  //                 imagePath: ImageConstant.imgSettingsWhiteA700,
  //                 height: 21.v,
  //                 width: 31.h,
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(
  //                   left: 9.h,
  //                   top: 2.v,
  //                 ),
  //                 child: Text(
  //                   "75%",
  //                   style: theme.textTheme.bodyLarge,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         CustomImageView(
  //           imagePath: ImageConstant.imgTelevisionWhiteA700,
  //           height: 17.v,
  //           width: 35.h,
  //           margin: EdgeInsets.only(
  //             left: 3.h,
  //             top: 3.v,
  //             bottom: 2.v,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
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
