import 'package:masaj/core/app_export.dart';

import '../models/giftcardlist_item_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GiftcardlistItemWidget extends StatelessWidget {
  GiftcardlistItemWidget(
    this.giftcardlistItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  GiftcardlistItemModel giftcardlistItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: AppDecoration.outlineGray30001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60.adaptSize,
            width: 60.adaptSize,
            decoration: AppDecoration.gradientOnErrorToRed.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: CustomImageView(
              imagePath: giftcardlistItemModelObj?.imageClass,
              height: 60.adaptSize,
              width: 60.adaptSize,
              alignment: Alignment.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8.w,
              top: 4.h,
              bottom: 6.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  giftcardlistItemModelObj.text1!,
                  style: CustomTextStyles.bodyMediumGray90003,
                ),
                SizedBox(height: 4.h),
                Text(
                  giftcardlistItemModelObj.text2!,
                  style: CustomTextStyles.titleMediumGray90003,
                ),
              ],
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgCopy,
            height: 16.adaptSize,
            width: 16.adaptSize,
            margin: EdgeInsets.only(
              top: 4.h,
              bottom: 39.h,
            ),
          ),
        ],
      ),
    );
  }
}
