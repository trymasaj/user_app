import 'dart:io';
import 'package:flutter/foundation.dart';

enum OS { iOS, Android, MacOS, Fuchsia, Linux, Windows, Unknown }

abstract class SystemService {
  DateTime get now;

  bool get isWeb;

  bool get isDesktop;

  bool get isMobile;

  OS get currentOS;
}

class SystemServiceImpl implements SystemService {
  @override
  OS get currentOS => _getCurrentOS();

  @override
  bool get isDesktop => Platform.isMacOS || Platform.isLinux || Platform.isWindows;

  @override
  bool get isMobile => Platform.isIOS || Platform.isAndroid;

  @override
  bool get isWeb => kIsWeb;

  @override
  DateTime get now => DateTime.now();

  OS _getCurrentOS() {
    if (Platform.isMacOS) {
      return OS.MacOS;
    }
    if (Platform.isFuchsia) {
      return OS.Fuchsia;
    }
    if (Platform.isLinux) {
      return OS.Linux;
    }
    if (Platform.isWindows) {
      return OS.Windows;
    }
    if (Platform.isIOS) {
      return OS.iOS;
    }
    if (Platform.isAndroid) {
      return OS.Android;
    }
    return OS.Unknown;
  }
}
