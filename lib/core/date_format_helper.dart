import 'package:easy_localization/easy_localization.dart';

class DateFormatHelper {
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
    return dateFormat.format(dateTime);
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
}
