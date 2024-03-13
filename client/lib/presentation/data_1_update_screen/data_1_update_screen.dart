import 'package:client/core/app_export.dart';
import 'package:client/presentation/search_update_page/search_update_page.dart';

import 'package:client/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class Data1UpdateScreen extends StatefulWidget {
  const Data1UpdateScreen({super.key});

  @override
  State<Data1UpdateScreen> createState() => _Data1UpdateScreenState();
}

class _Data1UpdateScreenState extends State<Data1UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    print('Test 2 : ${customer.CarID}');
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Text("Customer"),
          backgroundColor: AppDecoration.fillBlue.color),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(0.5, 0),
                  end: Alignment(0.5, 0.34),
                  colors: [appTheme.blue900, appTheme.blue900])),
          child: SizedBox(
              width: double.maxFinite,
              child: Column(children: [
                SizedBox(height: 5.v),
                Expanded(
                    child: Container(
                        child: Column(children: [
                  // _buildHeadRow(context),
                  SizedBox(height: 15.v),
                  _buildUserRow(context),
                  SizedBox(height: 20.v),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: Column(
                              children: [
                                SizedBox(height: 20.v),
                                Image.network(customer.Car_Image,
                                    height: 200.v,
                                    width: 430.h,
                                    alignment: Alignment.topCenter),
                                SizedBox(height: 10.v),
                                _buildInformationCar(context),
                                SizedBox(height: 10.v),
                                Divider(
                                    thickness: 1, color: appTheme.blueGray100),
                                SizedBox(height: 10.v),
                                _buildContactColumn(context),
                                SizedBox(height: 20.v),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 0.h),
                                  child: CustomElevatedButton(
                                    width: 150.h,
                                    text: "New case",
                                    buttonStyle: CustomButtonStyles.fillBlue,
                                    buttonTextStyle:
                                        CustomTextStyles.titleMediumBluegray50,
                                    onPressed: () {
                                      Navigator.pushNamed(context,
                                          AppRoutes.cameraUpdateScreen);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )))
                ]))),
              ]))),
    ));
  }

  Widget _buildUserRow(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 35.h, vertical: 22.v),
        decoration: AppDecoration.outlineBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder20),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          ClipOval(
            child: Image.network(
              customer.Customer_image,
              height: 72.v,
              width: 74.h,
            ),
          ),
          Container(
              width: 165.h,
              margin: EdgeInsets.only(left: 20.h, top: 21.v, bottom: 8.v),
              child: Text(
                  "${customer.First_name} ${customer.Last_name}\n${customer.CarID}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.bodyLargeNunitoBlack900_1))
        ]));
  }

  Widget _buildContactColumn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 0.h),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Contact",
            style: CustomTextStyles.titleLargeBold,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Email :",
                style: CustomTextStyles.bodyLargeNunitoBlack900,
                textAlign: TextAlign.left,
              ),
              Text(
                "${customer.Email}",
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.right,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Phone number :",
                style: CustomTextStyles.bodyLargeNunitoBlack900,
                textAlign: TextAlign.left,
              ),
              Text(
                "${customer.Phone_number}",
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.right,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Line ID :",
                style: CustomTextStyles.bodyLargeNunitoBlack900,
                textAlign: TextAlign.left,
              ),
              Text(
                "${customer.Line}",
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildInformationCar(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(right: 0.h),
    padding: EdgeInsets.symmetric(horizontal: 20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Information",
          style: CustomTextStyles.titleLargeBold,
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Address ",
              style: CustomTextStyles.bodyLargeNunitoBlack900,
              textAlign: TextAlign.left,
            ),
            Text(
              "${customer.Address}",
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Model ",
              style: CustomTextStyles.bodyLargeNunitoBlack900,
              textAlign: TextAlign.left,
            ),
            Text(
              "${customer.Model}",
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Color ",
              style: CustomTextStyles.bodyLargeNunitoBlack900,
              textAlign: TextAlign.left,
            ),
            Text(
              "${customer.Color}",
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Policy Number",
              style: CustomTextStyles.bodyLargeNunitoBlack900,
              textAlign: TextAlign.left,
            ),
            Text(
              "${customer.Policy_number}",
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Type of Insurance",
              style: CustomTextStyles.bodyLargeNunitoBlack900,
              textAlign: TextAlign.left,
            ),
            Text(
              "${customer.Policy_type}",
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Start / End",
              style: CustomTextStyles.bodyLargeNunitoBlack900,
              textAlign: TextAlign.left,
            ),
            Text(
              "${extractDate(customer.Start_date)} / ${extractDate(customer.End_date)}",
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ],
    ),
  );
}

String extractDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}
