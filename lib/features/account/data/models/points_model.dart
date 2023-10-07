// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PointsModel {
  final int? cursor;
  final num? total;
  final num? current;
  final List<PointItem>? points;

  PointsModel({
    this.cursor,
    this.total,
    this.current,
    this.points,
  });

  PointsModel copyWith({
    int? cursor,
    num? total,
    num? current,
    List<PointItem>? points,
  }) {
    return PointsModel(
      cursor: cursor ?? this.cursor,
      total: total ?? this.total,
      current: current ?? this.current,
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cursor': cursor,
      'total': total,
      'current': current,
      'points': points?.map((x) => x.toMap()).toList(),
    };
  }

  factory PointsModel.fromMap(Map<String, dynamic> map) {
    return PointsModel(
        cursor: map['cursor'] != null ? map['cursor'] as int : null,
        total: map['total'] != null ? map['total'] as num : null,
        current: map['current'] != null ? map['current'] as num : null,
        points: map['points'] != null
            ? List<PointItem>.from((map['points'] as List)
                .map((x) => PointItem.fromMap(x as Map<String, dynamic>)))
            : null);
  }

  String toJson() => json.encode(toMap());

  factory PointsModel.fromJson(String source) =>
      PointsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PointsModel(cursor: $cursor, total: $total, current: $current, points: $points)';
  }

  @override
  bool operator ==(covariant PointsModel other) {
    if (identical(this, other)) return true;

    return other.cursor == cursor &&
        other.total == total &&
        other.current == current &&
        listEquals(other.points, points);
  }

  @override
  int get hashCode {
    return cursor.hashCode ^
        total.hashCode ^
        current.hashCode ^
        points.hashCode;
  }
}

class PointItem {
  final int id;
  final String? title;
  final int? points;
  final bool? isEarned;
  final DateTime? date;
  PointItem({
    required this.id,
    this.title,
    this.points,
    this.isEarned,
    this.date,
  });

  PointItem copyWith({
    int? id,
    String? title,
    int? points,
    bool? isEarned,
    DateTime? date,
  }) {
    return PointItem(
      id: id ?? this.id,
      title: title ?? this.title,
      points: points ?? this.points,
      isEarned: isEarned ?? this.isEarned,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'points': points,
      'isEarned': isEarned,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory PointItem.fromMap(Map<String, dynamic> map) {
    return PointItem(
      id: map['id']?.toInt() ?? 0,
      title: map['title'],
      points: map['points']?.toInt(),
      isEarned: map['isEarned'],
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PointItem.fromJson(String source) =>
      PointItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PointItem(id: $id, title: $title, points: $points, isEarned: $isEarned, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PointItem &&
        other.id == id &&
        other.title == title &&
        other.points == points &&
        other.isEarned == isEarned &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        points.hashCode ^
        isEarned.hashCode ^
        date.hashCode;
  }
}
