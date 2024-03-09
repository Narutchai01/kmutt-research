import 'package:client/core/app_export.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      type: BottomBarEnum.Circumsearch,
    ),
    BottomMenuModel(
      type: BottomBarEnum.Fluenttasklist20filled,
    ),
    BottomMenuModel(
      type: BottomBarEnum.Lock,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CurvedNavigationBar(
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
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Circumsearch,
  Fluenttasklist20filled,
  Lock,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.type,
  });
  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
