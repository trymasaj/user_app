import 'package:masaj/core/app_export.dart';

class TimeSlotModel {
  final DateTime date;
  TimeSlotModel(this.date);
  String get monthAndDay {
    if (DateTime.now().day == date.day) {
      return 'Today';
    }
    return DateFormat('E  MMMM  d').format(date);
  }

  String get hour {
    return DateFormat('hh').format(date);
  }

  String get minute => DateFormat('mm').format(date);

  String get amPm => DateFormat('a').format(date);
  static List<TimeSlotModel> generateTimeSlots() {
    return List.generate(10, (index) {
      return TimeSlotModel(DateTime.now().add(Duration(hours: index * 5)));
    });
  }
}