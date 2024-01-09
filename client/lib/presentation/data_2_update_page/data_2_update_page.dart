import '../data_2_update_page/widgets/listsection_item_widget.dart';
import 'package:client/core/app_export.dart';
import 'package:client/widgets/custom_drop_down.dart';
import 'package:client/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class Data2UpdatePage extends StatelessWidget {
  Data2UpdatePage({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillWhiteA,
                child: Column(children: [
                  _buildMainSection(context),
                  SizedBox(height: 17.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 37.h, right: 51.h),
                          child: Row(children: [
                            SizedBox(
                                width: 100.h,
                                child: Text(
                                    "PDN :\nClaim info :\nStatus : \nCreate on : ",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleLarge)),
                            Container(
                                width: 113.h,
                                margin:
                                    EdgeInsets.only(left: 127.h, bottom: 2.v),
                                child: Text("POL-001\n\nSuccess\n12-10-2023",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.titleLargeBold))
                          ]))),
                  SizedBox(height: 26.v),
                  CustomImageView(
                      imagePath: ImageConstant.imgRectangle133,
                      height: 253.v,
                      width: 430.h),
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
                ]))));
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
    return SizedBox(
        height: 58.v,
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 30.h),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(width: 20.h);
            },
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListsectionItemWidget();
            }));
  }

  /// Navigates to the statusUpdateScreen when the action is triggered.
}
