import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/utils/size_utils.dart';
import 'package:masaj/core/widgets/selection_popup_model.dart';
import 'package:masaj/res/theme/custom_text_style.dart';
import 'package:masaj/res/theme/theme_helper.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(13.h),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray50014,
        borderRadius: BorderRadius.circular(19.h),
      );
  static BoxDecoration get gradientSecondaryContainerToDeepOrange =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(12.h),
        gradient: LinearGradient(
          begin: Alignment(0.0, 0),
          end: Alignment(1.0, 0),
          colors: [
            theme.colorScheme.secondaryContainer.withOpacity(0.09),
            appTheme.deepOrange200.withOpacity(0.09),
          ],
        ),
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: appTheme.gray10002,
          width: 1.h,
        ),
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        borderRadius: BorderRadius.circular(22.h),
      );
  static BoxDecoration get outlineOnPrimary => BoxDecoration(
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: theme.colorScheme.onPrimary.withOpacity(0.4),
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineOnPrimaryContainer => BoxDecoration(
        borderRadius: BorderRadius.circular(9.h),
        border: Border.all(
          color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGrayTL20 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        borderRadius: BorderRadius.circular(20.h),
        border: Border.all(
          color: appTheme.gray20002,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBlack => BoxDecoration(
        borderRadius: BorderRadius.circular(8.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.05),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              1,
            ),
          ),
        ],
      );
  static BoxDecoration get fillGrayTL8 => BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadius.circular(8.h),
      );
  static BoxDecoration get outlineBlackTL15 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        borderRadius: BorderRadius.circular(15.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get fillGrayTL22 => BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadius.circular(22.h),
      );
  static BoxDecoration get fillGrayTL18 => BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadius.circular(18.h),
      );
  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black90001,
        borderRadius: BorderRadius.circular(22.h),
      );
  static BoxDecoration get fillBlackTL17 => BoxDecoration(
        color: appTheme.black90001,
        borderRadius: BorderRadius.circular(17.h),
      );
  static BoxDecoration get fillPrimaryTL20 => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.h),
      );
}
