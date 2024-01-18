import 'package:flutter/material.dart';

class AppColors {
  static const PRIMARY_COLOR = Color(0xFFEFB287);
  static const PRIMARY_DARK_COLOR = Color(0xFFEDA674);
//EAEAEA
  static const BORDER_COLOR = Color(0xFFEAEAEA);
  static const SECONDARY_COLOR = Color(0xFF4C8DBE);
  static const THIRD_COLOR = Color(0xFFFB8636);
  static const ACCENT_COLOR = Color(0xFF31225D);
  static const BACKGROUND_COLOR = Color(0xFFE5E5E5);
  static const GREY_LIGHT_COLOR = Color(0xFFE2E2E2);
  static const GREY_NORMAL_COLOR = Color(0xFFB9B9B9);
  static const GREY_DARK_COLOR = Color(0xFF707070);
  static const RED_PURPLE = Color(0xff181B28);
  static const FONT_LIGHT = Color.fromARGB(255, 24, 27, 40);
  // F0F0F0
  static const GREY_LIGHT_COLOR_2 = Color(0xFFF0F0F0);

  static const FONT_COLOR = Color(0xFF1D212C);
  static const FONT_LIGHT_COLOR = Color.fromRGBO(24, 27, 40, 0.7);

  static const SUCCESS_COLOR = Color(0xFF24770F);
  static const ERROR_COLOR = Color(0xFFB73E53);
  //background: #F6F6F6;
  static const ExtraLight = Color(0xFFF6F6F6);
  static const PlaceholderColor = Color(0xff8C8C8C);

  static LinearGradient get GRADIENT_COLOR => const LinearGradient(
        begin: Alignment.centerLeft, // or Alignment(-1.0, 0.0)
        end: Alignment.centerRight, // or Alignment(1.0, 0.0)
        stops: [0, 0.9667],
        colors: [
          Color(0xFFCCA3B7),
          Color(0xFFEDA674),
        ],
      );
  static LinearGradient get GRADIENT_Fill_COLOR => LinearGradient(
        begin: Alignment.centerLeft, // or Alignment(-1.0, 0.0)
        end: Alignment.centerRight, // or Alignment(1.0, 0.0)
        // stops: [0, 0.9667],
        colors: [
          const Color(0xFFCCA3B7).withOpacity(.1),
          const Color(0xFFEDA674).withOpacity(.1),
          const Color(0xffEFB287).withOpacity(.1)
        ],
      );

  static const SHADOW = [
    BoxShadow(
      color: Color(0x99000000),
      spreadRadius: 0.03,
      blurRadius: 6,
    ),
  ];

  static const SHADOW_LIGHT = [
    BoxShadow(
      color: Color(0x44000000),
      spreadRadius: 0.03,
      blurRadius: 6,
    ),
  ];
}
