import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/wallet/models/userprofile8_item_model.dart';

// ignore: must_be_immutable
class WalletPackageCard extends StatelessWidget {
  WalletPackageCard(
    this.userprofile8ItemModelObj, {
    super.key,
  });

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
            imagePath: userprofile8ItemModelObj.clockImage,
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
