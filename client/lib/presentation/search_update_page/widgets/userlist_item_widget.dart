import 'package:client/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserlistItemWidget extends StatelessWidget {
  UserlistItemWidget({
    Key? key,
    this.onTapTxtUserName,
  }) : super(
          key: key,
        );

  VoidCallback? onTapTxtUserName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgEllipse33,
            height: 72.v,
            width: 74.h,
            radius: BorderRadius.circular(
              37.h,
            ),
            margin: EdgeInsets.only(bottom: 17.v),
          ),
          GestureDetector(
            // onTap: () {
            //   Navigator.pushNamed(context, '/data1UpdateScreen');
            // },
            onTap: onTapTxtUserName,
            child: Container(
              width: 163.h,
              margin: EdgeInsets.only(
                left: 26.h,
                top: 16.v,
                bottom: 29.v,
              ),
              child: Text(
                "Anthony Edward Stark\nYC7I AWH",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.bodyLargeNunitoBlack900_1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
