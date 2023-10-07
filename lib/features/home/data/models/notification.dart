// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class NotificationsModel {
  final int? cursor;
  final List<Notification>? notifications;
  NotificationsModel({
    this.cursor,
    this.notifications,
  });

  NotificationsModel copyWith({
    int? cursor,
    List<Notification>? notifications,
  }) {
    return NotificationsModel(
      cursor: cursor ?? this.cursor,
      notifications: notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cursor': cursor,
      'notifications': notifications?.map((x) => x.toMap()).toList(),
    }..removeWhere((_, v) => v == null);
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      cursor: map['cursor'] != null ? map['cursor'] as int : null,
      notifications: map['data'] != null
          ? List<Notification>.from(
              (map['data']).map<Notification?>(
                (x) => Notification.fromMap(x as Map<String, dynamic>),
              ),
            )
          : map['notifications'] != null
              ? List<Notification>.from(
                  (map['notifications']).map<Notification?>(
                    (x) => Notification.fromMap(x as Map<String, dynamic>),
                  ),
                )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsModel.fromJson(String source) =>
      NotificationsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NotificationsModel(cursor: $cursor, notifications: $notifications)';

  @override
  bool operator ==(covariant NotificationsModel other) {
    if (identical(this, other)) return true;

    return other.cursor == cursor &&
        listEquals(other.notifications, notifications);
  }

  @override
  int get hashCode => cursor.hashCode ^ notifications.hashCode;
}

class Notification {
  final int? id;
  final String? title;
  final String? message;
  final bool? seen;
  Notification({
    this.id,
    this.title,
    this.message,
    this.seen,
  });

  Notification copyWith({
    int? id,
    String? title,
    String? message,
    bool? seen,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      seen: seen ?? this.seen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'message': message,
      'seen': seen,
    }..removeWhere((_, v) => v == null);
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      seen: map['seen'] != null ? map['seen'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notification(id: $id, title: $title, message: $message, seen: $seen)';
  }

  @override
  bool operator ==(covariant Notification other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.message == message &&
        other.seen == seen;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ message.hashCode ^ seen.hashCode;
  }
}
