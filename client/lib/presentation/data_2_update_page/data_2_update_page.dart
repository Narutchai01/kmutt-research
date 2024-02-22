import 'package:client/presentation/profile_update_container_screen/profile_update_container_screen.dart';
import 'package:dio/dio.dart';
import 'package:client/core/app_export.dart';
import 'package:client/widgets/custom_drop_down.dart';
import 'package:client/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

get dataImgURL {
  String dataImgURL =
      "https://kmutt-api.onrender.com/api/report/getreport?caseID=f12d220c-ef64-45e9-a98d-fc61e42823e7";
  return dataImgURL;
}

List<dynamic> dataImgLink = [];
Map<String, dynamic> dataReport = {};

class Data2UpdatePage extends StatefulWidget {
  Data2UpdatePage({Key? key}) : super(key: key);

  @override
  _Data2UpdatePageState createState() => _Data2UpdatePageState();
}

// ignore_for_file: must_be_immutable
class _Data2UpdatePageState extends State<Data2UpdatePage> {
  int imgpreview = 0;
  final dio = Dio();

  Future getDataIMG() async {
    final response = await dio.get(dataImgURL);
    dataImgLink = response.data['ImageArr'];
    dataReport = response.data['report'];
    // print(response.data);
  }

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  @override
  Widget build(BuildContext context) {
    // getDataIMG();
    getPageroute(AppRoutes.data2UpdatePage);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: getDataIMG(),
            builder: (context, snapshot) {
              return Container(
                  width: double.maxFinite,
                  decoration: AppDecoration.fillWhiteA,
                  child: Column(children: [
                    _buildMainSection(context),
                    SizedBox(height: 17.v),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 37.h, right: 51.h),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "PDN :",
                                        style: theme.textTheme.titleLarge,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "POL-001",
                                        style: CustomTextStyles.titleLargeBold,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Claim Info:",
                                        style: theme.textTheme.titleLarge,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "",
                                        style: CustomTextStyles.titleLargeBold,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Status :",
                                        style: theme.textTheme.titleLarge,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "Success",
                                        style: CustomTextStyles.titleLargeBold,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Create on :",
                                        style: theme.textTheme.titleLarge,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "12-10-2023",
                                        style: CustomTextStyles.titleLargeBold,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ]))),
                    SizedBox(height: 26.v),
                    // CustomImageView(
                    //     imagePath: dataImgLink[imgpreview]["Image_link"],
                    //     height: 253.v,
                    //     width: 430.h),
                    SizedBox(height: 9.v),
                    _buildListSection(context),
                    SizedBox(height: 16.v),
                    Padding(
                        padding: EdgeInsets.only(left: 28.h, right: 29.h),
                        child: CustomDropDown(
                            hintText: "Filters",
                            items: dropdownItemList,
                            onChanged: (value) {})),
                    Spacer(),
                    SizedBox(height: 27.v),
                    CustomElevatedButton(
                      width: 150.h,
                      text: "Export result",
                      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                    )
                  ]));
            }),
      ),
    );
  }

  /// Section Widget
  Widget _buildMainSection(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 2.v),
        decoration: AppDecoration.fillBlue,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 17.v),
              Padding(
                  padding: EdgeInsets.only(left: 5.h),
                  child: Row(children: [
                    Spacer(),
                  ])),
              SizedBox(height: 10.v),
              Padding(
                  padding: EdgeInsets.only(left: 9.h),
                  child: Text("Result", style: theme.textTheme.displayMedium))
            ]));
  }

  /// Section Widget
  Widget _buildListSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      height: 58.adaptSize,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dataImgLink.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                imgpreview = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 8.0), // Adjust as needed
              width: 58.adaptSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.h),
                image: DecorationImage(
                  image: NetworkImage(dataImgLink[index]["Image_link"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Navigates to the statusUpdateScreen when the action is triggered.
}
