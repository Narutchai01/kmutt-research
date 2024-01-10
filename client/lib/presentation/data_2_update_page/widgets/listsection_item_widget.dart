import 'package:client/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListsectionItemWidget extends StatelessWidget {
  const ListsectionItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.adaptSize,
      width: 58.adaptSize,
      decoration: BoxDecoration(
        color: appTheme.blueGray100,
        borderRadius: BorderRadius.circular(
          5.h,
        ),
      ),
    );
  }
}
