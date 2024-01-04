import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:masaj/core/utils/size_utils.dart';
import 'package:masaj/res/theme/theme_helper.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillGray => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray90003,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.w),
        ),
      );
  static ButtonStyle get fillGrayTL12 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray5001,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
      );
  static ButtonStyle get fillGrayTL13 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray10002,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.w),
        ),
      );
  static ButtonStyle get fillGrayTL17 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray10002,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17.w),
        ),
      );
  static ButtonStyle get fillGrayTL20 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray20001,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
      );
  static ButtonStyle get fillGrayTL24 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray10002,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.w),
        ),
      );
  static ButtonStyle get fillGrayTL28 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray10002,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.w),
        ),
      );
  static ButtonStyle get fillGrayTL9 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.w),
        ),
      );
  static ButtonStyle get fillOnPrimaryContainer => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.w),
        ),
      );
  static ButtonStyle get fillOnPrimaryContainerTL28 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.w),
        ),
      );
  static ButtonStyle get fillPink => ElevatedButton.styleFrom(
        backgroundColor: appTheme.pink700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
      );
  static ButtonStyle get fillPinkTL24 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.pink70019,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.w),
        ),
      );

  // Gradient button style
  static BoxDecoration get gradientSecondaryContainerToDeepOrangeDecoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
        gradient: LinearGradient(
          begin: Alignment(0.0, 0),
          end: Alignment(1.0, 0),
          colors: [
            theme.colorScheme.secondaryContainer.withOpacity(0.09),
            appTheme.deepOrange200.withOpacity(0.09),
          ],
        ),
      );
  static BoxDecoration get gradientSecondaryContainerToDeepOrangeADecoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(28.w),
        gradient: LinearGradient(
          begin: Alignment(0.0, 0),
          end: Alignment(1.0, 0),
          colors: [
            theme.colorScheme.secondaryContainer,
            appTheme.deepOrangeA10001,
          ],
        ),
      );
  static BoxDecoration
      get gradientSecondaryContainerToDeepOrangeTL17Decoration => BoxDecoration(
            borderRadius: BorderRadius.circular(17.w),
            gradient: LinearGradient(
              begin: Alignment(0.0, 0),
              end: Alignment(1.0, 0),
              colors: [
                theme.colorScheme.secondaryContainer.withOpacity(0.14),
                appTheme.deepOrange200.withOpacity(0.14),
              ],
            ),
          );
  static BoxDecoration
      get gradientSecondaryContainerToDeepOrangeTL18Decoration => BoxDecoration(
            borderRadius: BorderRadius.circular(18.w),
            gradient: LinearGradient(
              begin: Alignment(0.0, 0),
              end: Alignment(1.0, 0),
              colors: [
                theme.colorScheme.secondaryContainer,
                appTheme.deepOrange200,
              ],
            ),
          );
  static BoxDecoration
      get gradientSecondaryContainerToDeepOrangeTL28Decoration => BoxDecoration(
            borderRadius: BorderRadius.circular(28.w),
            gradient: LinearGradient(
              begin: Alignment(0.0, 0),
              end: Alignment(1.0, 0),
              colors: [
                theme.colorScheme.secondaryContainer,
                appTheme.deepOrange200,
              ],
            ),
          );
  static BoxDecoration get gradientSecondaryContainerToPrimaryDecoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(28.w),
        gradient: LinearGradient(
          begin: Alignment(0.0, 0),
          end: Alignment(1.0, 0),
          colors: [
            theme.colorScheme.secondaryContainer,
            theme.colorScheme.primary,
          ],
        ),
      );
  static BoxDecoration get gradientSecondaryContainerToPrimaryTL16Decoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        gradient: LinearGradient(
          begin: Alignment(0.0, 0),
          end: Alignment(1.0, 0),
          colors: [
            theme.colorScheme.secondaryContainer,
            theme.colorScheme.primary,
          ],
        ),
      );
  static BoxDecoration get gradientSecondaryContainerToPrimaryTL25Decoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(25.w),
        gradient: LinearGradient(
          begin: Alignment(0.0, 0),
          end: Alignment(1.0, 0),
          colors: [
            theme.colorScheme.secondaryContainer,
            theme.colorScheme.primary,
          ],
        ),
      );
  static BoxDecoration get gradientSecondaryContainerToPrimaryTL6Decoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(6.w),
        gradient: LinearGradient(
          begin: Alignment(0.0, 0),
          end: Alignment(1.0, 0),
          colors: [
            theme.colorScheme.secondaryContainer,
            theme.colorScheme.primary,
          ],
        ),
      );

  // Outline button style
  static ButtonStyle get outline => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.w),
        ),
      );
  static ButtonStyle get outlineBlueGray => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        side: BorderSide(
          color: appTheme.blueGray100,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
      );
  static ButtonStyle get outlineBlueGrayTL16 => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: appTheme.blueGray40001,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.w),
        ),
      );
  static ButtonStyle get outlineGray => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        side: BorderSide(
          color: appTheme.gray90003,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
        ),
      );
  static ButtonStyle get outlinePink => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: appTheme.pink700,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.w),
        ),
      );
  static ButtonStyle get outlinePrimary => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        side: BorderSide(
          color: theme.colorScheme.primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.w),
        ),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
