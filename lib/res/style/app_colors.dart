import 'package:flutter/material.dart';

import '../../core/abstract/base_cubit.dart';

class AppColors {
  static const PRIMARY_COLOR = Color(0xFFDF2A57);
  static const SECONDARY_COLOR = Color(0xFF4C8DBE);
  static const THIRD_COLOR = Color(0xFFFB8636);
  static const ACCENT_COLOR = Color(0xFF31225D);
  static const BACKGROUND_COLOR = Color(0xFFE5E5E5);
  static const GREY_LIGHT_COLOR = Color(0xFFE2E2E2);
  static const GREY_NORMAL_COLOR = Color(0xFFB9B9B9);
  static const GREY_DARK_COLOR = Color(0xFF707070);
  static const FONT_PRIMARY_COLOR = Color(0xFF1D212C);
  static const FONT_SECONDARY_COLOR = Color.fromRGBO(24, 27, 40, 0.7);

  static LinearGradient get GRADIENT_COLOR => const LinearGradient(
        begin: Alignment.centerLeft, // or Alignment(-1.0, 0.0)
        end: Alignment.centerRight, // or Alignment(1.0, 0.0)
        stops: [0, 0.9667],
        colors: [
          Color(0xFFCCA3B7),
          Color(0xFFEDA674),
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
