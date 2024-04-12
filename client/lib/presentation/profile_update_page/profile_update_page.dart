import 'dart:async';

import 'package:client/presentation/user_profile_update_page/user_profile_update_page.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:client/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:client/presentation/login_screen/login_screen.dart';
import 'package:client/presentation/model/User_model.dart';

// ignore_for_file: must_be_immutable

StringModel Profile1 = StringModel(
  First_name: '',
  Last_name: '',
  SurveyorID: '',
  Birth_date: '',
  Image: '',
  Email: '',
  Phone_number: '',
  Password: '',
);

String tokenCheck = "";

get baseURL {
  String baseUrl = "https://kmutt-api.onrender.com/api";
  return baseUrl;
}

// get baseURL {
//   String baseUrl = "http://10.0.2.2:8080/api";
//   return baseUrl;
// }

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  @override
  void initState() {
    // getValidationData().whenComplete(() async {
    //   Timer(Duration(seconds: 2),
    //       () => Get.to(tokenCheck == "" ? LoginScreen() : ProfileUpdatePage()));
    // });

    super.initState();
  }

  final dio = Dio();
  var data;
  List<dynamic> caseList = [];

  Future<StringModel> getSurveyorInfo(BuildContext context) async {
    var response = await dio.get(
      '$baseURL/surveyor/findSurveyorByID/${GlobalModel.token}',
      options: Options(
        responseType: ResponseType.json,
        validateStatus: (statusCode) {
          if (statusCode == null) {
            return false;
          }
          if (statusCode == 400) {
            // your http status code
            return true;
          } else {
            return statusCode >= 200 && statusCode < 300;
          }
        },
      ),
    );
    Profile1 = StringModel.fromMap(response.data[0]);
    return Profile1;
  }

  Future<List<dynamic>> getCase() async {
    final response = await dio.get('$baseURL/cases/getCase');
    caseList = response.data;
    return caseList;
  }

  TextEditingController editTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: appTheme.whiteA700,
          resizeToAvoidBottomInset: false,
          body: FutureBuilder<StringModel>(
              future: getSurveyorInfo(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  Profile1 = snapshot.data!;
                  return Container(
                    width: double.maxFinite,
                    decoration: AppDecoration.fillBlue,
                    child: Column(
                      children: [
                        SizedBox(height: 10.v),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 43.v),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 105.v,
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(left: 54.h),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          height: 31.v,
                                          width: 110.h,
                                          margin: EdgeInsets.only(
                                            right: 155.h,
                                            bottom: 19.v,
                                          ),
                                          decoration: BoxDecoration(
                                            color: appTheme.whiteA700,
                                            borderRadius: BorderRadius.circular(
                                              10.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                child: CustomImageView(
                                                  imagePath: Profile1.Image,
                                                  height: 90.v,
                                                  width: 93.h,
                                                  radius: BorderRadius.circular(
                                                    46.h,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 20.v,
                                                bottom: 15.v,
                                                left: 30.h,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${Profile1.First_name} ${Profile1.Last_name}',
                                                    style: CustomTextStyles
                                                        .titleLargeWhiteA700,
                                                  ),
                                                  SizedBox(height: 7.v),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.h),
                                                    child: Text(
                                                      "${changeFormat(Profile1.SurveyorID)}",
                                                      style: CustomTextStyles
                                                          .titleLargeBlue900,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 52.v),
                              Expanded(
                                child: Container(
                                    height: 600.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 34.h,
                                      vertical: 10.v,
                                    ),
                                    decoration:
                                        AppDecoration.fillWhiteA.copyWith(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(0.0),
                                      ),
                                    ),
                                    child: FutureBuilder<List<dynamic>>(
                                      future: getCase(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'),
                                          );
                                        } else if (snapshot.hasData) {
                                          List<dynamic> data = caseList;
                                          int doneCases = 0;
                                          int numallcase = data.length;
                                          caseList.forEach((data) {
                                            if (data['Status'] == 'Success') {
                                              doneCases++;
                                            }
                                          });

                                          return Container(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgMdiGraphLine,
                                                        height: 24.adaptSize,
                                                        width: 24.adaptSize,
                                                        margin: EdgeInsets.only(
                                                          top: 8.v,
                                                          bottom: 4.v,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5.h),
                                                        child: Text(
                                                          "Statistics",
                                                          style: theme.textTheme
                                                              .headlineLarge,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 6.v),
                                                Container(
                                                    height: 160.v,
                                                    width: 361.h,
                                                    decoration: BoxDecoration(
                                                        color: appTheme.blue100,
                                                        borderRadius: BorderRadius
                                                            .horizontal(
                                                                right: Radius
                                                                    .circular(
                                                                        10.h),
                                                                left: Radius
                                                                    .circular(
                                                                        10.h))),
                                                    child: _chart(data)),
                                                SizedBox(height: 38.v),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomImageView(
                                                        imagePath: ImageConstant
                                                            .summaryIcon,
                                                        height: 25.v,
                                                        width: 25.h,
                                                        margin: EdgeInsets.only(
                                                          top: 6.v,
                                                          bottom: 8.v,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.h),
                                                        child: Text(
                                                          "Summary",
                                                          style: CustomTextStyles
                                                              .headlineSmallInter,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5.v),
                                                Container(
                                                  height: 70.v,
                                                  width: 361.h,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        appTheme.blue100,
                                                        appTheme.blue900,
                                                      ],
                                                      begin:
                                                          Alignment.centerRight,
                                                      end: Alignment.centerLeft,
                                                      stops: [0.97, 0.03],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.horizontal(
                                                      right:
                                                          Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.horizontal(
                                                      right:
                                                          Radius.circular(10.h),
                                                    ),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                        left: 20.h,
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "All Cases : $numallcase",
                                                          style: TextStyle(
                                                            fontSize: 25.0,
                                                          ),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 25.v),
                                                Container(
                                                  height: 70.v,
                                                  width: 361.h,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        appTheme.blue100,
                                                        appTheme.blue900,
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      stops: [0.97, 0.03],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.horizontal(
                                                      left:
                                                          Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.horizontal(
                                                      right:
                                                          Radius.circular(10.h),
                                                    ),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          right: 20.h),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          "Done Cases : $doneCases",
                                                          style: TextStyle(
                                                            fontSize: 25.0,
                                                          ),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 25.v),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return SizedBox(height: 52.v);
                                        }
                                      },
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })),
    );
  }
}

Widget _chart(List<dynamic> data) {
  Map<DateTime, int> casesPerDay = _countCasesPerDay(data);

  // Check if there is any data to display
  if (casesPerDay.isEmpty) {
    return Center(
      child: Text('No data available'),
    );
  }

  DateTime firstDate = casesPerDay.keys.reduce((a, b) => a.isBefore(b) ? a : b);
  DateTime lastDate = casesPerDay.keys.reduce((a, b) => a.isAfter(b) ? a : b);

  // Create a list of entries with dates and corresponding case counts
  List<MapEntry<DateTime, int>> chartData = [];
  for (DateTime date = firstDate;
      !date.isAfter(lastDate);
      date = date.add(Duration(days: 1))) {
    int cases = casesPerDay[date] ?? 0;
    chartData.add(MapEntry(date, cases));
  }

  int minCases =
      chartData.map((entry) => entry.value).reduce((a, b) => a < b ? a : b);
  int maxCases =
      chartData.map((entry) => entry.value).reduce((a, b) => a > b ? a : b);

  return SfCartesianChart(
    title: ChartTitle(text: 'Cases Per Day'),
    legend: Legend(isVisible: false),
    primaryXAxis: DateTimeAxis(
      title: AxisTitle(text: 'Date'),
      dateFormat: DateFormat.MMMd(),
      intervalType: DateTimeIntervalType.days,
      minimum: firstDate,
      maximum: lastDate,
      majorGridLines: MajorGridLines(width: 1),
    ),
    primaryYAxis: NumericAxis(
      minimum: minCases.toDouble(),
      maximum: maxCases.toDouble(),
      majorGridLines: MajorGridLines(width: 0),
      desiredIntervals: maxCases,
    ),
    series: <CartesianSeries>[
      LineSeries<MapEntry<DateTime, int>, DateTime>(
        dataSource: chartData,
        xValueMapper: (MapEntry<DateTime, int> entry, _) => entry.key,
        yValueMapper: (MapEntry<DateTime, int> entry, _) => entry.value,
        markerSettings: MarkerSettings(isVisible: true),
      ),
    ],
  );
}

Map<DateTime, int> _countCasesPerDay(List<dynamic> caseList) {
  Map<DateTime, int> casesPerDay = {};

  caseList.forEach((data) {
    if (data.containsKey('Date_opened')) {
      DateTime dateOpened = DateTime.parse(data['Date_opened']).toLocal();
      DateTime dateOnly = DateTime(
        dateOpened.year,
        dateOpened.month,
        dateOpened.day,
      );
      casesPerDay.update(dateOnly, (value) => value + 1, ifAbsent: () => 1);
    }
  });

  return casesPerDay;
}
