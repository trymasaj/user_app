// import '../../util/serialization/serialization_lib.dart';

enum LogLevel { verbose, debug, info, warning, error }

abstract class AbsLogger {
  List<String>? _tagFilters = [];

  LogLevel? _logLevel = LogLevel.verbose;

  /// enables table rendering for lists and maps (or Serializables)
  bool enableLongLogs = false;
  int longLogLength = 2000;
  int logLength = 900;
  bool splitLog = true;

  //abstract
  void writeLogLine(LogLevel? ll, String line);

  List<String> getSavedLogs();

  void clearSavedLogs();

  ///sets the log level that should be displayed, lower levels won't be shown.
  ///
  ///set to null to stop showing any logs
  void setLogLevel(LogLevel? ll) {
    _logLevel = ll;
    print("__log level set to $ll __");
  }

  ///prevents all kind of logs from appearing in the console
  void disableLogging() {
    setLogLevel(null);
    print("__loging disabled__");
  }

  void verbose(String name, [Object? value = "", String? tag = null]) {
    writeLog(LogLevel.verbose, name, value, tag);
  }

  void info(String name, [Object? value = "", String? tag = null]) {
    writeLog(LogLevel.info, name, value, tag);
  }

  void debug(String name, [Object? value = "", String? tag = null]) {
    writeLog(LogLevel.debug, name, value, tag);
  }

  void warning(String name, [Object? value = "", String? tag = null]) {
    writeLog(LogLevel.warning, name, value, tag);
  }

  void error(String name, [Object? value = "", String? tag = null]) {
    writeLog(LogLevel.error, name, value, tag);
  }

  String logLevelName(LogLevel ll) {
    return ll == LogLevel.verbose
        ? 'VERBOSE'
        : ll == LogLevel.debug
            ? 'DEBUG'
            : ll == LogLevel.info
                ? 'INFO'
                : ll == LogLevel.warning
                    ? 'WARNING'
                    : ll == LogLevel.error
                        ? 'ERROR'
                        : '';
  }

  String renderList(List list) {
    String l = "";
    l += "length: ${list.length} , items: [ ";
    list.forEach((item) {
      l += item.toString() + " , ";
    });
    l += " ]";
    return l;
  }

  String renderMap(Map map) {
    {
      return map.toString();
    }
  }

  String renderItemString(dynamic item) {
    var s = item.toString();
    if (!enableLongLogs && s.length > longLogLength) {
      return '<Tooo Long, Enable long logs to see>';
    }
    return s;
  }

  ///add a tag to tag filters so that only logs with these tags will show
  void addTagFilter(String tag) {
    _tagFilters?.add(tag);
    print("__logs are now filtered by tags (${_tagFilters?.join("-")})__");
  }

  void clearFilterTags() {
    _tagFilters?.clear();
    print("__logging tag filters cleared__");
  }

  /// does the requird processing before writeLogLine() writes it
  void writeLog(LogLevel ll, String name, [Object? value = "", String? tag]) {
    if (_logLevel == null) return;

    if (ll.index >= _logLevel!.index && (_tagFilters?.length == 0 || _tagFilters!.contains(tag))) {
      String valueString = "";
      //
      if (value != null) {
        // if (value is Serializable) {
        //   valueString = renderMap(value.toMap());
        // } else
        if (value is Map) {
          valueString = renderMap(value);
        } else if (value is List) {
          valueString = renderList(value);
        } else {
          valueString = value.toString();
        }
      }
      //

      var logString = "${tag != null ? '($tag): ' : ''}$name => ${valueString}";

      if (splitLog) {
        int length = logString.length;
        if (!enableLongLogs && length > longLogLength) {
          length = longLogLength;
        }
        //
        int startIndex = 0;

        while (length > logLength) {
          writeLogLine(ll, logLevelName(ll) + ' ' + logString.substring(startIndex, startIndex + logLength));
          startIndex += logLength;
          length -= logLength;
        }
        writeLogLine(ll, logLevelName(ll) + ' ' + logString.substring(startIndex, startIndex + length));
        //
        writeLogLine(null, "-----------------");
      } else {
        // the entire log is single unit
        if (!enableLongLogs && logString.length > longLogLength) {
          writeLogLine(ll, logLevelName(ll) + ' ' + logString.substring(0, longLogLength));
        } else {
          writeLogLine(ll, logLevelName(ll) + ' ' + logString);
        }
      }
    }
  }
}
