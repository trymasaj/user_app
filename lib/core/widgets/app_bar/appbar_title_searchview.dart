import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/widgets/custom_search_view.dart';

// ignore: must_be_immutable
class AppbarTitleSearchview extends StatelessWidget {
  AppbarTitleSearchview({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
  }) : super(
          key: key,
        );

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomSearchView(
        width: 299.w,
        controller: controller,
        hintText: "lbl_search".tr(),
        hintStyle: CustomTextStyles.bodyMediumDMSansBluegray40001_1,
        borderDecoration: SearchViewStyleHelper.fillGrayTL8,
        fillColor: appTheme.gray5001,
      ),
    );
  }
}
