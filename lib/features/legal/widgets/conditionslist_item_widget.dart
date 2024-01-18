import 'package:masaj/core/app_export.dart';

import 'package:masaj/features/legal/models/conditionslist_item_model.dart';
import 'package:flutter/material.dart';

class ConditionsListItem extends StatelessWidget {
  const ConditionsListItem(
    this.item, {
    super.key,
  });

  final Condition item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 17.h),
          child: Text(
            item.name,
            style: CustomTextStyles.bodyMediumOnPrimary_2,
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgThumbsUp,
          height: 18.adaptSize,
          width: 18.adaptSize,
          margin: EdgeInsets.only(bottom: 20.h),
        ),
      ],
    );
  }
}
