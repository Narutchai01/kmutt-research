import 'package:client/presentation/data_1_update_screen/data_1_update_screen.dart';
import 'package:dio/dio.dart';
import '../search_update_page/widgets/userlist_item_widget.dart';
import 'package:client/core/app_export.dart';
import 'package:client/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class SearchUpdatePage extends StatelessWidget {
  SearchUpdatePage({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  final dio = Dio();
  void getCustomer(BuildContext context) async {
    final response =
        await dio.get('http://10.0.2.2:8080/api/customer/getCustomer');
    print(response);
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   getCustomer(context);
  //   return SafeArea(
  //       top: false,
  //       bottom: false,
  //       left: false,
  //       right: false,
  //       child: Scaffold(
  //           backgroundColor: appTheme.blue900,
  //           body: Container(
  //               width: double.maxFinite,
  //               decoration: AppDecoration.fillBlue,
  //               child: Column(children: [
  //                 SizedBox(height: 10.v),
  //                 Expanded(
  //                     child: SingleChildScrollView(
  //                         child: Column(children: [
  //                   // _buildHeadRow(context),
  //                   SizedBox(height: 31.v),
  //                   Padding(
  //                       padding: EdgeInsets.only(left: 44.h, right: 43.h),
  //                       child: CustomSearchView(
  //                           controller: searchController, hintText: "CAR ID")),
  //                   SizedBox(height: 42.v),
  //                   Container(
  //                       height: 900.h,
  //                       padding: EdgeInsets.symmetric(
  //                           horizontal: 25.h, vertical: 22.v),
  //                       decoration: AppDecoration.fillWhiteA.copyWith(
  //                         borderRadius: BorderRadius.only(
  //                           topLeft: Radius.circular(20.0),
  //                           topRight: Radius.circular(20.0),
  //                           bottomLeft: Radius.circular(0.0),
  //                           bottomRight: Radius.circular(0.0),
  //                         ),
  //                       ),
  //                       child: Column(
  //                           mainAxisSize: MainAxisSize.min,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Padding(
  //                                 padding: EdgeInsets.only(left: 10.h),
  //                                 child: Text("Recent",
  //                                     style: theme.textTheme.headlineLarge)),
  //                             SizedBox(height: 33.v),
  //                             _buildUserList(context),
  //                             SizedBox(height: 33.v)
  //                           ])),
  //                   SizedBox(height: 53.v),
  //                 ])))
  //               ]))));
  // }

  /// Section Widget
  // Widget _buildUserList(BuildContext context) {
  //   return Padding(
  //       padding: EdgeInsets.only(right: 4.h),
  //       child: ListView.separated(
  //           physics: NeverScrollableScrollPhysics(),
  //           shrinkWrap: true,
  //           separatorBuilder: (context, index) {
  //             return Padding(
  //                 padding: EdgeInsets.symmetric(vertical: 8.0.v),
  //                 child: SizedBox(
  //                     width: 376.h,
  //                     child: Divider(
  //                         height: 1.v,
  //                         thickness: 1.v,
  //                         color: appTheme.gray100)));
  //           },
  //           itemCount: 2,
  //           itemBuilder: (context, index) {
  //             String userName = "Anthony Edward Stark";
  //             return UserlistItemWidget(onTapTxtUserName: () {
  //               onTapTxtUserName(context, userName);
  //             });
  //           }));
  // }

  /// Navigates to the data1UpdateScreen when the action is triggered.
  // void onTapTxtUserName(BuildContext context, String userName) {
  //   if (userName == "Anthony Edward Stark") {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => Data1UpdateScreen()),
  //     );
  //   } else {
  //     print("Invalid username: $userName");
  //   }
  // }
}
