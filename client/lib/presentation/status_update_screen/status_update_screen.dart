import 'package:client/core/app_export.dart';
import 'package:client/presentation/data_2_update_page/data_2_update_page.dart';
import 'package:client/presentation/model/case_model.dart';
import 'package:client/presentation/profile_update_page/profile_update_page.dart';
import 'package:client/presentation/search_update_page/search_update_page.dart';
import 'package:client/presentation/user_profile_update_page/user_profile_update_page.dart';
import 'package:client/widgets/custom_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class StatusUpdateScreen extends StatefulWidget {
  @override
  _StatusUpdateScreenState createState() => _StatusUpdateScreenState();
}

class _StatusUpdateScreenState extends State<StatusUpdateScreen> {
  CaseModel _dataFromAPI = CaseModel();
  final dio = Dio();
  var data = [];
  bool isSearch = true;
  // void getCase(BuildContext context) async {
  //   final response = await dio.get(
  //     'http://10.0.2.2:8080/api/cases/getCase',
  //   );
  //   data = response.data;

  //   caseModels =
  //       List<CaseModel>.from(data.map((item) => CaseModel.fromMap(item)));

  //   // Print the list of CaseModels
  //   caseModels.map((caseModel) {
  //     caseModel.toMap();
  //   });
  //   print(data[5]);

  //   print(caseModels.length);
  // }
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    List<CaseModel> caseModels = await getCaseModel();
    print(caseModels);
    // Now you can use the caseModels list as needed
  }

  Future<List<CaseModel>> getCaseModel() async {
    final response = await dio.get(
      'http://10.0.2.2:8080/api/cases/getCase',
    );

    // Check if response.data is a List<dynamic>
    if (response.data is! List<dynamic>) {
      // Handle the unexpected data format
      throw Exception("Expected List<dynamic>, but got something else.");
    }

    // Convert the JSON array to a List of Maps
    List<Map<String, dynamic>> responseDataList =
        List<Map<String, dynamic>>.from(response.data);

    // Map each item in the list to a CaseModel instance
    List<CaseModel> caseModels =
        responseDataList.map((map) => CaseModel.fromJson(map)).toList();

    return caseModels;
  }

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
                              FutureBuilder<List<CaseModel>>(
                                  future: getCaseModel(),
                                  builder: (context,
                                      AsyncSnapshot<List<CaseModel>?>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (snapshot.data?.isEmpty ?? true) {
                                      return Text('No data');
                                    } else {
                                      return Column(
                                          children:
                                              snapshot.data!.map((caseModel) {
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 16.v),
                                          child: _buildThirtyThreeSection(
                                              context,
                                              snapshot.data!,
                                              snapshot.data!
                                                  .indexOf(caseModel)),
                                        );
                                      }).toList());
                                    }
                                  }),
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
      ),
    );
  }

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
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            width: isSearch ? 56 : 200,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: !isSearch ? Colors.white : appTheme.blue900,
            ),
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 16),
                  child: !isSearch
                      ? TextField(
                          decoration: InputDecoration(
                              hintText: 'Search...', border: InputBorder.none),
                          style: TextStyle(color: Colors.black),
                        )
                      : null,
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isSearch ? 32 : 0),
                        topRight: Radius.circular(32),
                        bottomLeft: Radius.circular(isSearch ? 32 : 0),
                        bottomRight: Radius.circular(32),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isSearch ? Icons.search : Icons.close,
                          color: isSearch ? Colors.white : Colors.black,
                          size: 35,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          isSearch = !isSearch;
                        });
                      }),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildSeventyTwoSection(BuildContext context) {
    return Container(
      height: 68.v,
      width: MediaQuery.of(context).size.width -
          16.h, // Adjust width according to screen size
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 18.v),
      decoration: AppDecoration.gradientBlueToBlue900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: const Row(
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

  Widget _buildThirtyThreeSection(
      BuildContext context, List<CaseModel> caseModels, int n) {
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
              caseModels.isNotEmpty
                  ? extractDate(caseModels[n].Date_opened)
                  : 'No data',
              // caseModels.isNotEmpty ? caseModels[n].Date_opened : 'No data',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Text(
              caseModels.isNotEmpty ? caseModels[n].CarID : 'No data',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Text(
              caseModels.isNotEmpty ? caseModels[n].Status : 'No data',
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

  String extractDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  void onTapCases(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Data2UpdatePage()),
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
