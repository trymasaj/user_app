
import 'dart:developer';
import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'logger_lib.dart';


class DebugLogger extends AbsLogger {
  late AnsiPen _verbosePen, _debugPen, _infoPen, _warningPen, _errorPen, _defaultPen;
  bool normalPrint = false;

  DebugLogger() {
    _verbosePen = AnsiPen()..rgb(r: 126/256, g: 78/265,b: 68/256);
    _debugPen = AnsiPen()..rgb(r: 55/256, g: 128/265,b: 73/256);
    _infoPen = AnsiPen()..rgb(r: 47/256, g: 146/265,b: 191/256);
    _warningPen = AnsiPen()..xterm(214);
    _errorPen = AnsiPen()..red();
    _defaultPen = AnsiPen()..xterm(8);
  }

  void enableAnsiColors(bool enable){
    ansiColorDisabled = !enable;
  }

  AnsiPen _getPen(LogLevel? ll) {
    return ll == LogLevel.verbose
        ? _verbosePen
        : ll == LogLevel.debug
            ? _debugPen
            : ll == LogLevel.info
                ? _infoPen
                : ll == LogLevel.warning
                    ? _warningPen
                    : ll == LogLevel.error
                        ? _errorPen
                        : _defaultPen;
  }

  @override
  List<String> getSavedLogs() {
    return [];
  }

  @override
  void clearSavedLogs() {
    // do nothing
  }

  @override
  void writeLogLine(LogLevel? ll, String line) {
    normalPrint? debugPrint(_getPen(ll).write(line)) : log(_getPen(ll).write(line));
  }
}
