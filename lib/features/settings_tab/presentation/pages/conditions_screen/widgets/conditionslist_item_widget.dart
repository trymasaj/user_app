import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/utils/image_constant.dart';
import 'package:masaj/core/widgets/custom_image_view.dart';
import 'package:masaj/res/theme/custom_text_style.dart';

import '../models/conditionslist_item_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConditionslistItemWidget extends StatelessWidget {
  ConditionslistItemWidget(
    this.conditionslistItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  ConditionslistItemModel conditionslistItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 17.h),
          child: Text(
            conditionslistItemModelObj.allergiesText!,
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
