import 'dart:collection';
import 'logger_lib.dart';

class MemoryLogger extends AbsLogger {
  final List<String> _logLines = <String>[];
  int maxLength = 50;

  MemoryLogger(){
    this.splitLog = false;
    this.enableLongLogs = true;
  }

  @override
  List<String> getSavedLogs() {
    return _logLines.toList();
  }

  @override
  void clearSavedLogs() {
    _logLines.clear();
  }

  @override
  void writeLogLine(LogLevel? ll, String line) {
    var now = DateTime.now();
    _logLines.add('${now.hour}:${now.minute}:${now.second} | $line');
    if(_logLines.length > maxLength){
      _logLines.removeAt(0);
    }
  }
}
