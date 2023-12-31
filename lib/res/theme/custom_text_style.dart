import 'package:flutter/material.dart';
import 'package:masaj/core/utils/size_utils.dart';
import 'package:masaj/res/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static TextStyle get bodyLargeGray90003 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray90003,
        fontSize: 18.fSize,
      );
  static TextStyle get bodyLargeGray90003_1 =>
      theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray90003,
      );
  static TextStyle get bodyLargeOnPrimaryContainer =>
      theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 18.fSize,
      );
  static TextStyle get bodyMediumBluegray40001 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray40001,
      );
  static TextStyle get bodyMediumBluegray40001_1 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray40001,
      );
  static TextStyle get bodyMediumBluegray90003 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray90003,
      );
  static TextStyle get bodyMediumDMSans => theme.textTheme.bodyMedium!.dMSans;
  static TextStyle get bodyMediumDMSansBluegray40001 =>
      theme.textTheme.bodyMedium!.dMSans.copyWith(
        color: appTheme.blueGray40001,
      );
  static TextStyle get bodyMediumDMSansBluegray40001_1 =>
      theme.textTheme.bodyMedium!.dMSans.copyWith(
        color: appTheme.blueGray40001,
      );
  static TextStyle get bodyMediumDMSansBluegray900 =>
      theme.textTheme.bodyMedium!.dMSans.copyWith(
        color: appTheme.blueGray900.withOpacity(0.64),
      );
  static TextStyle get bodyMediumDMSansBluegray90003 =>
      theme.textTheme.bodyMedium!.dMSans.copyWith(
        color: appTheme.blueGray90003,
      );
  static TextStyle get bodyMediumDMSansGray90003 =>
      theme.textTheme.bodyMedium!.dMSans.copyWith(
        color: appTheme.gray90003,
      );
  static TextStyle get bodyMediumDMSansOnPrimaryContainer =>
      theme.textTheme.bodyMedium!.dMSans.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static TextStyle get bodyMediumDMSans_1 => theme.textTheme.bodyMedium!.dMSans;
  static TextStyle get bodyMediumDeeporange400 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.deepOrange400,
      );
  static TextStyle get bodyMediumGray10002 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray10002,
      );
  static TextStyle get bodyMediumGray1000215 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray10002,
        fontSize: 15.fSize,
      );
  static TextStyle get bodyMediumGray60002 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray60002,
      );
  static TextStyle get bodyMediumGray90003 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray90003,
      );
  static TextStyle get bodyMediumGray90003_1 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray90003,
      );
  static TextStyle get bodyMediumGray90003_2 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray90003.withOpacity(0.52),
      );
  static TextStyle get bodyMediumLightgreen900 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.lightGreen900,
      );
  static TextStyle get bodyMediumManropeGray90003 =>
      theme.textTheme.bodyMedium!.manrope.copyWith(
        color: appTheme.gray90003,
      );
  static TextStyle get bodyMediumOnErrorContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static TextStyle get bodyMediumOnPrimary =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.53),
      );
  static TextStyle get bodyMediumOnPrimaryContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static TextStyle get bodyMediumOnPrimary_1 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.4),
      );
  static TextStyle get bodyMediumOnPrimary_2 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static TextStyle get bodyMediumPink700 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.pink700,
      );
  static TextStyle get bodyMediumSecondaryContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
  static TextStyle get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmall11 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 11.fSize,
      );
  static TextStyle get bodySmallAlmaraiGray90003 =>
      theme.textTheme.bodySmall!.almarai.copyWith(
        color: appTheme.gray90003,
      );
  static TextStyle get bodySmallBlack90001 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black90001.withOpacity(0.52),
      );
  static TextStyle get bodySmallBluegray40001 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray40001,
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallBluegray4000111 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray40001,
        fontSize: 11.fSize,
      );
  static TextStyle get bodySmallBluegray400019 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray40001,
        fontSize: 9.fSize,
      );
  static TextStyle get bodySmallBluegray40001_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray40001,
      );
  static TextStyle get bodySmallBluegray40001_2 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray40001,
      );
  static TextStyle get bodySmallDMSans => theme.textTheme.bodySmall!.dMSans;
  static TextStyle get bodySmallDMSansBluegray40001 =>
      theme.textTheme.bodySmall!.dMSans.copyWith(
        color: appTheme.blueGray40001,
        fontSize: 11.fSize,
      );
  static TextStyle get bodySmallDMSansOnPrimary =>
      theme.textTheme.bodySmall!.dMSans.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.4),
        fontSize: 11.fSize,
      );
  static TextStyle get bodySmallGray10001 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray10001,
      );
  static TextStyle get bodySmallGray10002 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray10002,
      );
  static TextStyle get bodySmallGray700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray700,
      );
  static TextStyle get bodySmallGray90003 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray90003,
        fontSize: 11.fSize,
      );
  static TextStyle get bodySmallGray90003_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray90003,
      );
  static TextStyle get bodySmallGray90003_2 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray90003,
      );
  static TextStyle get bodySmallLightgreen900 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.lightGreen900,
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallLightgreen900_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.lightGreen900,
      );
  static TextStyle get bodySmallOnPrimary =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.4),
        fontSize: 11.fSize,
      );
  static TextStyle get bodySmallOnPrimaryContainer =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 11.fSize,
      );
  static TextStyle get bodySmallOnPrimaryContainer11 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 11.fSize,
      );
  static TextStyle get bodySmallOnPrimary_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.4),
      );
  static TextStyle get bodySmallPink700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.pink700,
      );
  static TextStyle get bodySmallRedA700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.redA700,
      );
  static TextStyle get bodySmallRobotoGray800 =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: appTheme.gray800,
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallSecondaryContainer =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontSize: 10.fSize,
      );
  static TextStyle get bodySmallSecondaryContainer_1 =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
  // Display text style
  static TextStyle get displayMediumGray900 =>
      theme.textTheme.displayMedium!.copyWith(
        color: appTheme.gray900,
        fontWeight: FontWeight.w500,
      );
  // Headline text style
  static TextStyle get headlineSmallBluegray100 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.blueGray100,
      );
  static TextStyle get headlineSmallErrorContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.errorContainer,
      );
  static TextStyle get headlineSmallGray5001 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.gray5001,
      );
  static TextStyle get headlineSmallOnPrimary =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.7),
      );
  static TextStyle get headlineSmallOnPrimaryContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontWeight: FontWeight.w500,
      );
  static TextStyle get headlineSmallOnPrimaryContainer_1 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static TextStyle get headlineSmallOnPrimaryContainer_2 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static TextStyle get headlineSmallSecondaryContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
  static TextStyle get headlineSmallSofiaProOnPrimaryContainer =>
      theme.textTheme.headlineSmall!.sofiaPro.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontWeight: FontWeight.w700,
      );
  // Label text style
  static TextStyle get labelLargeBluegray40001 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray40001,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelLargeBluegray90002 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray90002,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelLargeDMSans => theme.textTheme.labelLarge!.dMSans;
  static TextStyle get labelLargeLightblueA700 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.lightBlueA700,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelLargeLightgreen900 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.lightGreen900,
      );
  static TextStyle get labelLargeOnPrimary =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.7),
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelLargeOnPrimaryContainer =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelLargeOnPrimaryContainerSemiBold =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelLargeOnPrimaryContainer_1 =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static TextStyle get labelLargeOnPrimary_1 =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.7),
      );
  static TextStyle get labelLargePink700 =>
      theme.textTheme.labelLarge!.copyWith(
        color: appTheme.pink700,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelLargePrimary =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelLargePrimary_1 =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static TextStyle get labelLargeSecondaryContainer =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
  static TextStyle get labelLargeSecondaryContainerSemiBold =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelLargeSemiBold =>
      theme.textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static TextStyle get labelMediumBluegray40001 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.blueGray40001,
      );
  static TextStyle get labelMediumOnPrimary =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.7),
      );
  static TextStyle get labelMediumOnPrimaryContainer =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static TextStyle get labelMediumOnPrimaryContainerBold =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 11.fSize,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get labelMediumPrimary =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static TextStyle get labelMediumSecondaryContainer =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
  static TextStyle get labelSmall8 => theme.textTheme.labelSmall!.copyWith(
        fontSize: 8.fSize,
      );
  static TextStyle get labelSmallBluegray40001 =>
      theme.textTheme.labelSmall!.copyWith(
        color: appTheme.blueGray40001,
        fontSize: 8.fSize,
      );
  // Title text style
  static TextStyle get titleLargeMedium => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static TextStyle get titleLargeOnPrimary =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.7),
        fontWeight: FontWeight.w400,
      );
  static TextStyle get titleLargeOnPrimaryContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 22.fSize,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get titleLargeOnPrimaryContainer_1 =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static TextStyle get titleLargeRegular =>
      theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  static TextStyle get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static TextStyle get titleMedium18_1 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static TextStyle get titleMedium18_2 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static TextStyle get titleMedium18_3 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static TextStyle get titleMediumBlack90001 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black90001,
      );
  static TextStyle get titleMediumBluegray800 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray800,
      );
  static TextStyle get titleMediumBluegray900 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray900,
        fontSize: 18.fSize,
      );
  static TextStyle get titleMediumBluegray90001 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray90001,
        fontSize: 18.fSize,
      );
  static TextStyle get titleMediumDMSans =>
      theme.textTheme.titleMedium!.dMSans.copyWith(
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumDMSansBluegray90003 =>
      theme.textTheme.titleMedium!.dMSans.copyWith(
        color: appTheme.blueGray90003,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumDMSansGray90003 =>
      theme.textTheme.titleMedium!.dMSans.copyWith(
        color: appTheme.gray90003,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumDMSansPink700 =>
      theme.textTheme.titleMedium!.dMSans.copyWith(
        color: appTheme.pink700,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumDMSansSecondaryContainer =>
      theme.textTheme.titleMedium!.dMSans.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleMediumErrorContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: 18.fSize,
      );
  static TextStyle get titleMediumGray90002 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray90002,
      );
  static TextStyle get titleMediumGray90003 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray90003,
      );
  static TextStyle get titleMediumGray9000318 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray90003,
        fontSize: 18.fSize,
      );
  static TextStyle get titleMediumGray90003SemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray90003,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleMediumGray90003_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray90003,
      );
  static TextStyle get titleMediumOnPrimary =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.7),
      );
  static TextStyle get titleMediumOnPrimary_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static TextStyle get titleMediumOnPrimary_2 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.7),
      );
  static TextStyle get titleMediumSecondaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
  static TextStyle get titleMediumSecondaryContainer18 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontSize: 18.fSize,
      );
  static TextStyle get titleMediumSecondaryContainer18_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontSize: 18.fSize,
      );
  static TextStyle get titleMediumSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleSmallBluegray40001 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray40001,
      );
  static TextStyle get titleSmallBluegray40001_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray40001,
      );
  static TextStyle get titleSmallDMSansOnPrimary =>
      theme.textTheme.titleSmall!.dMSans.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.4),
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleSmallDMSansSecondaryContainer =>
      theme.textTheme.titleSmall!.dMSans.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get titleSmallOnPrimary =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static TextStyle get titleSmallOnPrimaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleSmallOnPrimaryContainer_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
      );
  static TextStyle get titleSmallOnPrimary_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.4),
      );
  static TextStyle get titleSmallOnPrimary_2 =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.7),
      );
  static TextStyle get titleSmallOnPrimary_3 =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(0.7),
      );
  static TextStyle get titleSmallPink700 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.pink700,
      );
  static TextStyle get titleSmallSecondaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
  static TextStyle get titleSmallSemiBold =>
      theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static TextStyle get titleSmallSemiBold_1 =>
      theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get almarai {
    return copyWith(
      fontFamily: 'Almarai',
    );
  }

  TextStyle get dancingScript {
    return copyWith(
      fontFamily: 'Dancing Script',
    );
  }

  TextStyle get dMSans {
    return copyWith(
      fontFamily: 'DM Sans',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get manrope {
    return copyWith(
      fontFamily: 'Manrope',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get sofiaPro {
    return copyWith(
      fontFamily: 'Sofia Pro',
    );
  }
}
