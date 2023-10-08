import 'package:flutter/material.dart';

import '../../core/abstract/base_cubit.dart';

class AppColors {
  static const PRIMARY_COLOR = const Color(0xFFDF2A57);
  static const SECONDARY_COLOR = const Color(0xFF4C8DBE);
  static const THIRD_COLOR = const Color(0xFFFB8636);
  static const ACCENT_COLOR = const Color(0xFF31225D);
  static const BACKGROUND_COLOR = const Color(0xFFE5E5E5);
  static const GREY_LIGHT_COLOR = Color(0xFFE2E2E2);
  static const GREY_NORMAL_COLOR = Color(0xFFB9B9B9);
  static const GREY_DARK_COLOR = Color(0xFF707070);

  static LinearGradient get GRADIENT_COLOR => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.0, 0.3, 0.5, 0.8],
        colors: [
          ACCENT_COLOR.withAlpha(0),
          ACCENT_COLOR.withAlpha(110),
          ACCENT_COLOR.withAlpha(245),
          ACCENT_COLOR.withAlpha(255),
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
