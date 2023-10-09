import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

ThemeData theme(bool isArabic) {
  //TODO: Keep it as it is for now, but we need to change it if there is another font for English!
  final fontFamily = isArabic ? 'Poppins' : 'Poppins';
  return ThemeData(
    fontFamily: fontFamily,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyText1: _normalText(14.0, fontFamily),
      bodyText2: _normalText(16.0, fontFamily),
      headline1: _boldText(16.0, fontFamily),
      headline2: _boldText(18.0, fontFamily),
      headline3: _boldText(21.0, fontFamily),
      headline4: _boldText(24.0, fontFamily),
      headline5: _boldText(28.0, fontFamily),
      headline6: _boldText(32.0, fontFamily),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    colorScheme: const ColorScheme.light(primary: Colors.black),
    radioTheme: RadioThemeData(
      overlayColor: MaterialStateColor.resolveWith(
        (states) => AppColors.GREY_NORMAL_COLOR,
      ),
      fillColor: MaterialStateColor.resolveWith(
        (states) => AppColors.PRIMARY_COLOR,
      ),
    ),
  );
}

TextStyle _boldText(double size, String fontFamily) {
  return TextStyle(
    color: AppColors.FONT_COLOR,
    fontWeight: FontWeight.bold,
    fontSize: size,
    fontFamily: fontFamily,
  );
}

TextStyle _normalText(double size, String fontFamily) {
  return TextStyle(
    color: AppColors.FONT_COLOR,
    fontWeight: FontWeight.w400,
    fontSize: size,
    fontFamily: fontFamily,
  );
}

const navbarHeight = 100.0;
const sliverAppbarExtensionHeight = 200.0;
