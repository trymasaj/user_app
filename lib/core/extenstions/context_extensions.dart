import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension ContextExtensions on BuildContext {
  ScreenCoordinate getScreenCoordinate() {
    double screenWidth =
        MediaQuery.of(this).size.width * MediaQuery.of(this).devicePixelRatio;
    double screenHeight =
        MediaQuery.of(this).size.height * MediaQuery.of(this).devicePixelRatio;
    double middleX = screenWidth / 2;
    double middleY = screenHeight / 2;
    return ScreenCoordinate(x: middleX.round(), y: middleY.round());
  }
}
