import 'package:flutter/material.dart';

class AvailableTimeSlot {
  final String? timeString;
  int get hour => int.parse(timeString!.split(":")[0]);
  int get minute => int.parse(timeString!.split(":")[1]);
  int get second => int.parse(timeString!.split(":")[2]);

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);

  DateTime convertToDate(DateTime date) =>
      DateTime(date.year, date.month, date.day, hour, minute, second);
  // 10:00:00 pm
  String get timeString12HourFormat {
    final amOrPm = hour >= 12 ? 'pm' : 'am';
    final hourIn12Format = hour > 12 ? hour - 12 : hour;
    final hourStr = hourIn12Format == 0 ? '12' : hourIn12Format.toString();
    final minuteStr = minute < 10 ? '0$minute' : minute.toString();
    return '$hourStr : $minuteStr  $amOrPm';
  }

  AvailableTimeSlot({required this.timeString});

  AvailableTimeSlot copyWith({
    String? timeString,
  }) {
    return AvailableTimeSlot(
      timeString: timeString ?? this.timeString,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;

    return other is AvailableTimeSlot && other.timeString == timeString;
  }

  @override
  int get hashCode => timeString.hashCode;

  @override
  String toString() => 'AvailableTimeSlot(timeString: $timeString)';
}
