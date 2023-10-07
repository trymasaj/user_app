import 'dart:convert';

class NotificationModel {
  final int id;
  final int? notificationType;
  final String? title;
  final String message;
  final DateTime? date;
  bool isNew;
  NotificationModel({
    required this.id,
    this.notificationType,
    this.title,
    required this.message,
    this.date,
    required this.isNew,
  });

  NotificationModel copyWith({
    int? id,
    int? notificationType,
    String? title,
    String? message,
    DateTime? date,
    bool? isNew,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      notificationType: notificationType ?? this.notificationType,
      title: title ?? this.title,
      message: message ?? this.message,
      date: date ?? this.date,
      isNew: isNew ?? this.isNew,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'notificationType': notificationType,
      'title': title,
      'message': message,
      'date': date?.millisecondsSinceEpoch,
      'isNew': isNew,
    }..removeWhere((_, v) => v == null);
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id']?.toInt() ?? 0,
      notificationType: map['notificationType']?.toInt(),
      title: map['title'],
      message: map['message'] ?? '',
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
      isNew: map['isNew'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(id: $id, notificationType: $notificationType, title: $title, message: $message, date: $date, isNew: $isNew)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.id == id &&
        other.notificationType == notificationType &&
        other.title == title &&
        other.message == message &&
        other.date == date &&
        other.isNew == isNew;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        notificationType.hashCode ^
        title.hashCode ^
        message.hashCode ^
        date.hashCode ^
        isNew.hashCode;
  }
}
