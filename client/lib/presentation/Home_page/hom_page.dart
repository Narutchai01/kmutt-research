import 'package:client/presentation/profile_update_page/profile_update_page.dart';
import 'package:client/presentation/search_update_page/search_update_page.dart';
import 'package:client/presentation/status_update_screen/status_update_screen.dart';
import 'package:client/presentation/user_profile_update_page/user_profile_update_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:client/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

String finalToken = '';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  List<Widget> Menupage = [
    ProfileUpdatePage(),
    SearchUpdatePage(),
    StatusUpdateScreen(),
    UserProfileUpdatePage(),
  ];
  Future getToken() async {
    final SharedPreferences prefsToken = await SharedPreferences.getInstance();
    var finalToken = prefsToken.getString('token');
    setState(() {
      finalToken = finalToken.toString();
    });
    print(finalToken);
  }

  @override
  Widget build(BuildContext context) {
    getToken();
    return SafeArea(
      child: Scaffold(
        body: Menupage[currentPageIndex],
        backgroundColor: appTheme.whiteA700,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: appTheme.whiteA700,
          color: appTheme.blue900,
          animationDuration: Duration(milliseconds: 300),
          height: 55.0,
          items: [
            Icon(Icons.home, color: Colors.white, size: 40),
            Icon(Icons.search, color: Colors.white, size: 40),
            Icon(Icons.list, color: Colors.white, size: 40),
            Icon(Icons.account_circle_outlined, color: Colors.white, size: 40),
          ],
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
            print(index);
          },
        ),
      ),
    );
  }
}
