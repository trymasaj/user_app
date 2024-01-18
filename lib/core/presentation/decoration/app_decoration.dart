import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';

class AppDecoration {
  // Car decorations
  static BoxDecoration get car => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.gray50033,
            spreadRadius: 2.w,
            blurRadius: 2.w,
            offset: const Offset(
              0,
              5,
            ),
          ),
        ],
      );

  // Fill decorations
  static BoxDecoration get fill => BoxDecoration(
        color: appTheme.gray10001,
      );

  static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black90001,
      );

  static BoxDecoration get fillBlack900 => BoxDecoration(
        color: appTheme.black900,
      );

  static BoxDecoration get fillBlue => BoxDecoration(
        color: appTheme.blue5001,
      );

  static BoxDecoration get fillBlue50 => BoxDecoration(
        color: appTheme.blue50,
      );

  static BoxDecoration get fillCyan => BoxDecoration(
        color: appTheme.cyan100,
      );

  static BoxDecoration get fillDeepOrange => BoxDecoration(
        color: appTheme.deepOrange20016,
      );

  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray90003.withOpacity(0.5),
      );

  static BoxDecoration get fillGray100 => BoxDecoration(
        color: appTheme.gray100,
      );

  static BoxDecoration get fillGray10002 => BoxDecoration(
        color: appTheme.gray10002,
      );

  static BoxDecoration get fillGray20003 => BoxDecoration(
        color: appTheme.gray20003,
      );

  static BoxDecoration get fillGray5001 => BoxDecoration(
        color: appTheme.gray5001,
      );

  static BoxDecoration get fillGray80070 => BoxDecoration(
        color: appTheme.gray80070,
      );

  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.72),
      );

  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );

  static BoxDecoration get fillPink => BoxDecoration(
        color: appTheme.pink700,
      );

  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.08),
      );

  static BoxDecoration get fillPrimary1 => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
      );

  static BoxDecoration get fillPrimary2 => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.11),
      );

  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red400,
      );

  static BoxDecoration get fillYellow => BoxDecoration(
        color: appTheme.yellow100,
      );

  // Gradient decorations
  static BoxDecoration get gradientGrayToGray => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.5),
          end: const Alignment(1, 0.5),
          colors: [
            appTheme.gray400,
            appTheme.gray40003,
          ],
        ),
      );

  static BoxDecoration get gradientOnErrorToRed => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.5),
          end: const Alignment(1, 0.5),
          colors: [
            theme.colorScheme.onError,
            appTheme.red200,
          ],
        ),
      );

  static BoxDecoration get gradientSecondaryContainerToDeepOrangeA =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.5),
          end: const Alignment(1, 0.5),
          colors: [
            theme.colorScheme.secondaryContainer,
            appTheme.deepOrangeA100,
          ],
        ),
      );

  static BoxDecoration get gradientSecondaryContainerToPrimary => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.5),
          end: const Alignment(1, 0.5),
          colors: [
            theme.colorScheme.secondaryContainer,
            theme.colorScheme.primary,
          ],
        ),
      );

  static BoxDecoration get gradientSecondaryContainerToPrimary1 =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.5),
          end: const Alignment(1, 0.5),
          colors: [
            theme.colorScheme.secondaryContainer,
            theme.colorScheme.primary,
          ],
        ),
      );

  // Hh decorations
  static BoxDecoration get hh => const BoxDecoration();

  // Linear decorations
  static BoxDecoration get linear => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.5),
          end: const Alignment(1, 0.5),
          colors: [
            theme.colorScheme.secondaryContainer.withOpacity(0.09),
            theme.colorScheme.primary.withOpacity(0.09),
            appTheme.deepOrange200.withOpacity(0.09),
          ],
        ),
      );

  // Ll decorations
  static BoxDecoration get ll => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.5),
          end: const Alignment(1, 0.5),
          colors: [
            appTheme.blueGray500,
            appTheme.teal200,
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outline => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );

  static BoxDecoration get outlineBlack => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.13),
            spreadRadius: 2.w,
            blurRadius: 2.w,
            offset: const Offset(
              -1.28,
              1.2,
            ),
          ),
        ],
      );

  static BoxDecoration get outlineBlack90001 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.18),
            spreadRadius: 2.w,
            blurRadius: 2.w,
            offset: const Offset(
              0,
              0,
            ),
          ),
        ],
      );

  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.w,
        ),
      );

  static BoxDecoration get outlineBluegray100 => BoxDecoration(
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.w,
        ),
      );

  static BoxDecoration get outlineBluegray1001 => BoxDecoration(
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.w,
          strokeAlign: strokeAlignCenter,
        ),
      );


  static BoxDecoration get outlineDeepPurpleA => const BoxDecoration();
  static BoxDecoration get outlineDeeppurpleA200 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );

  static BoxDecoration get outlineGray => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.gray50033,
            spreadRadius: 2.w,
            blurRadius: 2.w,
            offset: const Offset(
              0,
              -1,
            ),
          ),
        ],
      );

  static BoxDecoration get outlineGray200 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.gray200,
          width: 1.w,
        ),
      );

  static BoxDecoration get outlineGray20003 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.gray20003,
          width: 1.w,
        ),
      );

  static BoxDecoration get outlineGray30001 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.gray30001,
          width: 1.w,
        ),
      );

  static BoxDecoration get outlineGray50033 => const BoxDecoration();

  static BoxDecoration get outlineIndigo => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.indigo20021,
            spreadRadius: 2.w,
            blurRadius: 2.w,
            offset: const Offset(
              0,
              -3,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineIndigo20021 => const BoxDecoration();

  // White decorations
  static BoxDecoration get white => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder28 => BorderRadius.circular(
        28.w,
      );

  // Custom borders
  static BorderRadius get customBorderTL28 => BorderRadius.vertical(
        top: Radius.circular(28.w),
      );

  static BorderRadius get customBorderTL32 => BorderRadius.vertical(
        top: Radius.circular(32.w),
      );

  static BorderRadius get customBorderTL38 => BorderRadius.vertical(
        top: Radius.circular(38.w),
      );

  static BorderRadius get customBorderTL4 => BorderRadius.vertical(
        top: Radius.circular(4.w),
      );

  // Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.w,
      );

  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.w,
      );

  static BorderRadius get roundedBorder19 => BorderRadius.circular(
        19.w,
      );

  static BorderRadius get roundedBorder48 => BorderRadius.circular(
        48.w,
      );

  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.w,
      );

  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.w,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
