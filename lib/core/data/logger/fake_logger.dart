

import 'logger_lib.dart';

class FakeLogger extends AbsLogger{

  FakeLogger(){
    this.setLogLevel(null);
  }

  @override
  void clearSavedLogs() {
    // do nothing
  }

  @override
  List<String> getSavedLogs() {
    return [];
  }

  @override
  void writeLog(LogLevel ll, String name, [Object? value = "", String? tag]) {
    // do nothing
  }

  @override
  void writeLogLine(LogLevel? ll, String line) {
    // do nothing
  }
  
}