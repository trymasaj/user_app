import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/size/size_utils.dart';
import 'package:masaj/core/presentation/theme/theme_helper.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.alignment,
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  });

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
                  borderRadius: BorderRadius.circular(13.w),
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
        borderRadius: BorderRadius.circular(19.w),
      );
  static BoxDecoration get gradientSecondaryContainerToDeepOrange =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
        gradient: LinearGradient(
          begin: const Alignment(0.0, 0),
          end: const Alignment(1.0, 0),
          colors: [
            theme.colorScheme.secondaryContainer.withOpacity(0.09),
            appTheme.deepOrange200.withOpacity(0.09),
          ],
        ),
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(
          color: appTheme.gray10002,
          width: 1.w,
        ),
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        borderRadius: BorderRadius.circular(22.w),
      );
  static BoxDecoration get outlineOnPrimary => BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(
          color: theme.colorScheme.onPrimary.withOpacity(0.4),
          width: 1.w,
        ),
      );
  static BoxDecoration get outlineOnPrimaryContainer => BoxDecoration(
        borderRadius: BorderRadius.circular(9.w),
        border: Border.all(
          color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
          width: 1.w,
        ),
      );
  static BoxDecoration get outlineGrayTL20 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(
          color: appTheme.gray20002,
          width: 1.w,
        ),
      );
  static BoxDecoration get outlineBlack => BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.05),
            spreadRadius: 2.w,
            blurRadius: 2.w,
            offset: const Offset(
              0,
              1,
            ),
          ),
        ],
      );
  static BoxDecoration get fillGrayTL8 => BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadius.circular(8.w),
      );
  static BoxDecoration get outlineBlackTL15 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        borderRadius: BorderRadius.circular(15.w),
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.25),
            spreadRadius: 2.w,
            blurRadius: 2.w,
            offset: const Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get fillGrayTL22 => BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadius.circular(22.w),
      );
  static BoxDecoration get fillGrayTL18 => BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadius.circular(18.w),
      );
  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black90001,
        borderRadius: BorderRadius.circular(22.w),
      );
  static BoxDecoration get fillBlackTL17 => BoxDecoration(
        color: appTheme.black90001,
        borderRadius: BorderRadius.circular(17.w),
      );
  static BoxDecoration get fillPrimaryTL20 => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.w),
      );
}
