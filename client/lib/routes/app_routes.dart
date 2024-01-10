import 'package:flutter/material.dart';
import 'package:client/presentation/login_screen/login_screen.dart';

import 'package:client/presentation/profile_update_container_screen/profile_update_container_screen.dart';
import 'package:client/presentation/data_1_update_screen/data_1_update_screen.dart';
import 'package:client/presentation/status_update_screen/status_update_screen.dart';
import 'package:client/presentation/camera_update_screen/camera_update_screen.dart';
import 'package:client/presentation/search_two_screen/search_two_screen.dart';
import 'package:client/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:client/presentation/data_2_update_page/data_2_update_page.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String profileUpdatePage = '/profile_update_page';

  static const String profileUpdateContainerScreen =
      '/profile_update_container_screen';

  static const String searchUpdatePage = '/search_update_page';

  static const String data1UpdateScreen = '/data_1_update_screen';

  static const String data2UpdatePage = '/data_2_update_page';

  static const String statusUpdateScreen = '/status_update_screen';

  static const String cameraUpdateScreen = '/camera_update_screen';

  static const String imagepickerUpdateScreen = '/imagepicker_update_screen';

  static const String imagepicker2UpdateScreen = '/imagepicker2_update_screen';

  static const String userProfileUpdatePage = '/user_profile_update_page';

  static const String searchTwoScreen = '/search_two_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String ProfileUpdatePage = '/profile_update_page';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    profileUpdateContainerScreen: (context) => ProfileUpdateContainerScreen(),
    data1UpdateScreen: (context) => Data1UpdateScreen(),
    statusUpdateScreen: (context) => StatusUpdateScreen(),
    cameraUpdateScreen: (context) => CameraUpdateScreen(),
    searchTwoScreen: (context) => SearchTwoScreen(),
    data2UpdatePage: (context) => Data2UpdatePage(),
    appNavigationScreen: (context) => AppNavigationScreen(),
  };
}
