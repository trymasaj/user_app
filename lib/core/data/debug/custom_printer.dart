import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class CustomPrinter {
  static JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  static String logJsonResponsePretty({String? title, required dynamic response}) {
    var sb = StringBuffer();
    if (response.runtimeType == Response<dynamic>) {
      String prettyResponse = encoder.convert(response.data);

      sb.writeln('[$title] StatusCode: ${response.statusCode}');
      sb.writeln('[$title] response:');
      sb.writeln(prettyResponse);
    } else {
      sb.writeln(response.toString());
    }
    return sb.toString();
  }

  static String logRequestPretty({String? title, String? url, Map<String, dynamic>? params, required Map<String, dynamic> header}) {
    var sb = StringBuffer();

    String prettyHeader = encoder.convert(header);

    sb.writeln('[$title] url: $url');

    if (params != null) {
      String prettyParams = encoder.convert(params);

      sb.writeln('[$title] params:');
      sb.writeln(prettyParams);
    }

    sb.writeln('[$title] headers:');
    sb.writeln(prettyHeader);
    //
    return sb.toString();
  }
}
