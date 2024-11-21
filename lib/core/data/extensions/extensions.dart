import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime {
  String formatDate() {
    // final dateFormat = DateFormat(
    //   'dd/MM/yyyy',
    //   'en',
    // );
    // return dateFormat.format(this);
    return '${this.day}/${this.month}/${this.year}';
  }

  String formateTime([bool is24HourFormat = false]) {
    final dateFormat = DateFormat(
      is24HourFormat ? 'HH:mm' : 'h:mm a',
      'en',
    );
    return dateFormat.format(this);
  }

  DateTime get withoutTime => DateTime(year, month, day);
}

extension TimeExtensions on Duration {
  String formatTime() {
    final dateFormat = DateFormat(
      'h:mm a',
      'en',
    );
    final time = DateTime(0).add(this);
    return dateFormat.format(time);
  }

  String parseDurationToCSharpTimeSpan() {
    final isNegative = this.isNegative;
    final days = inDays.abs();
    String formattedDuration = toString();

    if (days != 0) {
      final hours = inHours.abs() % 24;
      final minutes = inMinutes.abs() % 60;
      final seconds = inSeconds.abs() % 60;
      formattedDuration =
          '${days.toString()}.${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }

    if (days == 0) {
      formattedDuration = formattedDuration.split('.').first.padLeft(8, '0');
    }

    return isNegative ? '-$formattedDuration' : formattedDuration;
  }
}

extension DurationParsing on String {
  Duration parseCSharpTimeSpanDuration() {
    final regexp = RegExp(
        r'(?:(?<ne>-))?(?:(?:(?<dd>0*[0-9]+)[.])?(?:(?<HH>0*[2][0-3]|0*[1][0-9]|0*[0-9])[:]))?(?<mm>(?<=:)0*[0-5]?[0-9]|0*[5-9]?[0-9](?=[:]))(?:[:](?<ss>0*[0-5]?[0-9](?:[.][0-9]{0,7})?))?');

    final match = regexp.firstMatch(this);
    int days = int.parse((match?.namedGroup('dd')) ?? '0');
    int hours = int.parse((match?.namedGroup('HH')) ?? '0');
    int mins = int.parse((match?.namedGroup('mm')) ?? '0');
    int usecs =
        (double.parse((match?.namedGroup('ss')) ?? '0.0') * 1000000).round();
    bool negative = match?.namedGroup('ne') == '-';

    final duration =
        Duration(days: days, hours: hours, minutes: mins, microseconds: usecs);

    return negative ? Duration.zero - duration : duration;
  }

  DateTime parseDate() {
    //final dateFormat = DateFormat('dd/MM/yyyy', 'en');
    //return dateFormat.parse(this);
    var parts = this.split('/');
    return DateTime(num.parse(parts[2]).toInt(), num.parse(parts[1]).toInt(),num.parse(parts[0]).toInt(),);
  }

  DateTime parseTime([bool is24HourFormat = false]) {
    final dateFormat = DateFormat(
      is24HourFormat ? 'HH:mm' : 'h:mm a',
      'en',
    );
    return dateFormat.parse(this);
  }
}

extension IsAr on BuildContext {
  bool get isAr => EasyLocalization.of(this)!.locale.languageCode == 'ar';
}
