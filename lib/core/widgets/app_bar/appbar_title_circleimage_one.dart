import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTitleCircleimageOne extends StatelessWidget {
  AppbarTitleCircleimageOne({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadiusStyle.roundedBorder12,
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          imagePath: imagePath,
          height: 24.adaptSize,
          width: 24.adaptSize,
          fit: BoxFit.contain,
          radius: BorderRadius.circular(
            12.w,
          ),
        ),
      ),
    );
  }
}
