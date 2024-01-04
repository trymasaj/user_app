import 'package:masaj/core/app_export.dart';

import '../models/giftcardsection_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

// ignore: must_be_immutable
class GiftcardsectionItemWidget extends StatelessWidget {
  GiftcardsectionItemWidget(
    this.giftcardsectionItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  GiftcardsectionItemModel giftcardsectionItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      padding: EdgeInsets.symmetric(
        horizontal: 13.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgGroup1171,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 90.h,
              bottom: 4.h,
            ),
            child: Text(
              giftcardsectionItemModelObj.text!,
              style: CustomTextStyles.bodyMediumOnPrimaryContainer,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Column(
              children: [
                CustomImageView(
                  imagePath: giftcardsectionItemModelObj?.imageClass,
                  height: 26.adaptSize,
                  width: 26.adaptSize,
                  alignment: Alignment.centerRight,
                ),
                SizedBox(height: 51.h),
                Container(
                  width: 66.w,
                  margin: EdgeInsets.only(right: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        giftcardsectionItemModelObj.text1!,
                        style: CustomTextStyles.headlineSmallOnPrimaryContainer,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(
                          giftcardsectionItemModelObj.text2!,
                          style: theme.textTheme.titleMedium,
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
    );
  }
}
