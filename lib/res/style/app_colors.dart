import 'package:flutter/material.dart';

import '../../core/abstract/base_cubit.dart';

class AppColors extends BaseCubit<bool> {
  AppColors() : super(false);
  static final tempAppColorsList = <Map<String, String>>[];
  static int _currentIndexOfColors = -1;

  void undo() {
    if (_currentIndexOfColors == -1) return;
    final tempAppColors = tempAppColorsList.removeAt(_currentIndexOfColors);
    updateAppColors(
      tempAppColors['primaryColor'],
      tempAppColors['secondaryColor'],
      tempAppColors['thirdColor'],
      tempAppColors['accentColor'],
      tempAppColors['backgroundColor'],
    );
    _currentIndexOfColors--;
    emit(!state);
  }

  static String convertColorToHex(Color color) =>
      '0x${color.value.toRadixString(16)}';

  static void saveTempColors() {
    tempAppColorsList.add({
      'primaryColor': convertColorToHex(PRIMARY_COLOR),
      'secondaryColor': convertColorToHex(SECONDARY_COLOR),
      'thirdColor': convertColorToHex(THIRD_COLOR),
      'accentColor': convertColorToHex(ACCENT_COLOR),
      'backgroundColor': convertColorToHex(BACKGROUND_COLOR),
    });

    _currentIndexOfColors++;
  }

  static void updateAppColors(
    String? primaryColorCode,
    String? secondaryColorCode,
    String? thirdColorCode,
    String? accentColorCode,
    String? backgroundCode,
  ) {
    final primaryColor = primaryColorCode != null
        ? Color(int.parse(primaryColorCode.substring(2), radix: 16))
        : null;
    final secondaryColor = secondaryColorCode != null
        ? Color(int.parse(secondaryColorCode.substring(2), radix: 16))
        : null;
    final thirdColor = thirdColorCode != null
        ? Color(int.parse(thirdColorCode.substring(2), radix: 16))
        : null;
    final accentColor = accentColorCode != null
        ? Color(int.parse(accentColorCode.substring(2), radix: 16))
        : null;
    final backgroundColor = backgroundCode != null
        ? Color(int.parse(backgroundCode.substring(2), radix: 16))
        : null;

    PRIMARY_COLOR = primaryColor ?? PRIMARY_COLOR;
    SECONDARY_COLOR = secondaryColor ?? SECONDARY_COLOR;
    THIRD_COLOR = thirdColor ?? THIRD_COLOR;
    ACCENT_COLOR = accentColor ?? ACCENT_COLOR;
    BACKGROUND_COLOR = backgroundColor ?? BACKGROUND_COLOR;
  }

  static void resetAppColors() {
    PRIMARY_COLOR = const Color(0xFFDF2A57);
    SECONDARY_COLOR = const Color(0xFF4C8DBE);
    THIRD_COLOR = const Color(0xFFFB8636);
    ACCENT_COLOR = const Color(0xFF31225D);
    BACKGROUND_COLOR = const Color(0xFFE5E5E5);
  }

  static var PRIMARY_COLOR = const Color(0xFFDF2A57);
  static var SECONDARY_COLOR = const Color(0xFF4C8DBE);
  static var THIRD_COLOR = const Color(0xFFFB8636);
  static var ACCENT_COLOR = const Color(0xFF31225D);
  static var BACKGROUND_COLOR = const Color(0xFFE5E5E5);
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
