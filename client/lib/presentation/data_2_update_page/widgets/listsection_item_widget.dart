import 'package:client/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:client/presentation/data_2_update_page/data_2_update_page.dart';

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
        image: dataImgLink.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(dataImgLink[1]["Image_link"]),
                fit: BoxFit.cover,
              )
            : null,
        borderRadius: BorderRadius.circular(
          5.h,
        ),
      ),
    );
  }
}
