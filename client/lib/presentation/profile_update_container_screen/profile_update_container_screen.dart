import 'package:client/core/app_export.dart';
import 'package:client/presentation/camera_update_screen/camera_update_screen.dart';
import 'package:client/presentation/profile_update_page/profile_update_page.dart';
import 'package:client/presentation/search_update_page/search_update_page.dart';
import 'package:client/presentation/user_profile_update_page/user_profile_update_page.dart';
import 'package:client/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:client/presentation/status_update_screen/status_update_screen.dart';

class ProfileUpdateContainerScreen extends StatefulWidget {
  ProfileUpdateContainerScreen({Key? key}) : super(key: key);

  @override
  _ProfileUpdateContainerScreenState createState() =>
      _ProfileUpdateContainerScreenState();
}

class _ProfileUpdateContainerScreenState
    extends State<ProfileUpdateContainerScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  bool showBottomBar = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.profileUpdatePage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: showBottomBar ? _buildBottomBar(context) : null,
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(
        navigatorKey.currentContext!,
        getCurrentRoute(type),
      );
    });
  }

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

  Widget getCurrentPage(String currentRoute) {
    if (getPageroute(currentRoute) == AppRoutes.profileUpdatePage) {
      return ProfileUpdatePage();
    } else if (getPageroute(currentRoute) == AppRoutes.searchUpdatePage) {
      return SearchUpdatePage();
    } else if (getPageroute(currentRoute) == AppRoutes.statusUpdateScreen) {
      return StatusUpdateScreen();
    } else if (getPageroute(currentRoute) == AppRoutes.userProfileUpdatePage) {
      return UserProfileUpdatePage();
    }
    throw Exception('Invalid currentRoute');
  }
}

String getPageroute(String route) {
  print(route);
  return route;
}

void gocamrea(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CameraUpdateScreen()),
  );
}
