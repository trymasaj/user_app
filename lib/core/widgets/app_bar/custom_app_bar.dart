import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  }) : super(
          key: key,
        );

  final double? height;

  final Style? styleType;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 57.h,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 57.h,
      );
  Widget? _getStyle() {
    switch (styleType) {
      case Style.bgFill_1:
        return Stack(
          children: [
            Container(
              height: 64.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
              ),
            ),
            Container(
              height: 1.h,
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 64.h),
              decoration: BoxDecoration(
                color: appTheme.blueGray100,
              ),
            ),
          ],
        );
      case Style.bgFill_2:
        return Container(
          height: 1.h,
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 64.h),
          decoration: BoxDecoration(
            color: appTheme.blueGray100,
          ),
        );
      case Style.bgFill_3:
        return Container(
          height: 196.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.gray90003.withOpacity(0.5),
          ),
        );
      case Style.bgFill:
        return Container(
          height: 1.h,
          width: double.maxFinite,
          margin: EdgeInsets.only(
            top: 51.26.h,
            bottom: 3.7400055.h,
          ),
          decoration: BoxDecoration(
            color: appTheme.blueGray100,
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgFill_1,
  bgFill_2,
  bgFill_3,
  bgFill,
}
