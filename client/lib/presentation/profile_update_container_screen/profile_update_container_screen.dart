import 'package:client/core/app_export.dart';
import 'package:client/presentation/profile_update_page/profile_update_page.dart';
import 'package:client/presentation/search_update_page/search_update_page.dart';
import 'package:client/presentation/user_profile_update_page/user_profile_update_page.dart';
import 'package:client/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:client/presentation/status_update_screen/status_update_screen.dart';
import 'package:dio/dio.dart';

// ignore_for_file: must_be_immutable
class ProfileUpdateContainerScreen extends StatelessWidget {
  ProfileUpdateContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final dio = Dio();

  void getData(BuildContext context) async {
    final response = await dio.get(
      'http://localhost:8080/api/surveyor/getSurveyor',
    );
    print(response.data);
  }

  // void getID(BuildContext context) async {
  //   final response =
  //       await dio.get('http://localhost:8080/api/surveyor/findSurveyorByID');

  //   try {
  //     print(response.data);
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  //   print('Hello');
  // }

  @override
  Widget build(BuildContext context) {
    // getData(context);
    getData(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.blue900,
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.profileUpdatePage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
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
}
