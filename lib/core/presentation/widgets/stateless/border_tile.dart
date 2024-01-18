import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';

class BorderTile extends StatelessWidget {
  const BorderTile(
      {super.key,
      required this.image,
      required this.text,
      required this.onTap});

  final String image;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 16.h),
            decoration: AppDecoration.outlineBluegray1001
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                      imagePath: image,
                      height: 20.adaptSize,
                      width: 20.adaptSize),
                  Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(text,
                          style: theme.textTheme.titleSmall!
                              .copyWith(color: appTheme.gray90003))),
                  const Spacer(),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRightOnprimary,
                      height: 17.adaptSize,
                      width: 17.adaptSize,
                      radius: BorderRadius.circular(8.w),
                      margin: EdgeInsets.symmetric(vertical: 2.h))
                ])));
  }
}
