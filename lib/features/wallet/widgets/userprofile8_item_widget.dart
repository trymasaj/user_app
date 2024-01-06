import 'package:masaj/core/app_export.dart';

import '../models/userprofile8_item_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Userprofile8ItemWidget extends StatelessWidget {
  Userprofile8ItemWidget(
    this.userprofile8ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  Userprofile8ItemModel userprofile8ItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9.w),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: userprofile8ItemModelObj?.clockImage,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(bottom: 76.h),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 1.w,
              top: 19.h,
              bottom: 23.h,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userprofile8ItemModelObj.fiveText!,
                      style: theme.textTheme.headlineSmall,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 4.w,
                        top: 3.h,
                        bottom: 2.h,
                      ),
                      child: Text(
                        userprofile8ItemModelObj.kwdText!,
                        style: CustomTextStyles.titleLargeRegular,
                      ),
                    ),
                  ],
                ),
                Text(
                  userprofile8ItemModelObj.freeKwdText!,
                  style: CustomTextStyles.bodyMediumLightgreen900,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
