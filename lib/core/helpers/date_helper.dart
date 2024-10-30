import 'package:easy_localization/easy_localization.dart';

class DateHelper {
  static final dateFormat = DateFormat(
    'dd/MM/yyyy',
    'en',
  );
  static final dateTimeFormat = DateFormat(
    'h:mm a',
    'en',
  );
  static timeFormat(String lang) => DateFormat(
        'h:mm a',
        lang,
      );
  static String? formatDate(DateTime? dateTime) {
    if (dateTime == null) return null;
    //Expected Result: The date format should be Day, DD MM YYYY e.g. Monday 05 Aug 2024
    return DateFormat('EEEE dd MMM yyyy').format(dateTime);
  }

  static String? formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTimeFormat.format(dateTime);
  }

  static String? formatTime(Duration? duration, String lang) {
    if (duration == null) return null;
    final time = DateTime(0).add(duration);
    return timeFormat(lang).format(time);
  }

  // not used
  static String getWeekDay(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        return 'Sunday';
    }
  }

  static String getMonth(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'Febuary';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'Augest';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      default:
        return 'December';
    }
  }

  static String getTime(int hour, int minute) {
// with am or pm
    final amOrPm = hour >= 12 ? 'pm' : 'am';
    // 24 hour format to 12 hour format
    final hourIn12Format = hour > 12 ? hour - 12 : hour;
    // if hour is 0 then it is 12 am
    final hourStr = hourIn12Format == 0 ? '12' : hourIn12Format.toString();
    final minuteStr = minute < 10 ? '0$minute' : minute.toString();
    return '$hourStr:$minuteStr $amOrPm';
  }

// convert date to DateModel
  static DateModel convertDateToModel(DateTime date) {
    // day like 12
    // weekDay like Monday
    // month like January
    // year like 2021
    // time like 12:00 am
    final day = date.day.toString();
    final weekDay = getWeekDay(date.weekday);
    final month = getMonth(date.month);
    final year = date.year.toString();
    final time = getTime(date.hour, date.minute);
    return DateModel(
        day: day, weekDay: weekDay, month: month, year: year, time: time);
  }
}

// not used
class DateModel {
  final String day;
  final String weekDay;
  final String month;
  final String year;

  // am or pm
  final String time;

  DateModel(
      {required this.day,
      required this.weekDay,
      required this.month,
      required this.year,
      required this.time});

  @override
  String toString() {
    return '$day $weekDay $month $year $time';
  }
}
