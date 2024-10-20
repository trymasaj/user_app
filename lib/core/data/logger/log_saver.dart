import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

/// requires path_provider: ">=0.5.0+1 <2.0.0"
/// and permission <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
class LogSaver {
  Future<String> _getStoragePath() async {
    if (Platform.isAndroid) {
      return "/storage/emulated/0/";
    } else {
      //IOS
      var path = (await path_provider.getLibraryDirectory()).path;

      return path;
    }
  }

  Future<File> _writeStringToPrivateFile(
      String someString, String fileName) async {
    var writeMode = FileMode.append;

    return File(join((await _getStoragePath()), fileName))
        .writeAsString(someString, mode: writeMode);
  }

  Future writeLogToPrivateFile(List<String> log, String fileName) async {
    var writeMode = FileMode.append;

    var file = File((await _getStoragePath()) + fileName + ".txt");

    for (var line in log) {
      await file.writeAsString(line, mode: writeMode);
      await file.writeAsString("\r\n\r\n", mode: writeMode);
    }
  }

  Future copyLogToClipboard(List<String> log) async {
    String logString = log.join("\r\n\r\n");

    await Clipboard.setData(ClipboardData(text: logString));
  }

  Future copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

}
