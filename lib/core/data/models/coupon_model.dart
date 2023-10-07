import 'dart:convert';

import 'package:flutter/foundation.dart';

class Coupon {
  final int? cursor;
  final List<CouponItem> data;
  Coupon({
    this.cursor,
    required this.data,
  });

  Coupon copyWith({
    int? cursor,
    List<CouponItem>? data,
  }) {
    return Coupon(
      cursor: cursor ?? this.cursor,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cursor': cursor,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory Coupon.fromMap(Map<String, dynamic> map) {
    return Coupon(
      cursor: map['cursor']?.toInt(),
      data:
          List<CouponItem>.from(map['data']?.map((x) => CouponItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Coupon.fromJson(String source) => Coupon.fromMap(json.decode(source));

  @override
  String toString() => 'Coupon(cursor: $cursor, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coupon &&
        other.cursor == cursor &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => cursor.hashCode ^ data.hashCode;
}

class CouponItem {
  final int id;
  final String name;
  final String picture;
  final String? description;
  final int? points;
  final DateTime startDate;
  final DateTime endDate;
  CouponItem({
    required this.id,
    required this.name,
    required this.picture,
    this.description,
    this.points,
    required this.startDate,
    required this.endDate,
  });

  CouponItem copyWith({
    int? id,
    String? name,
    String? picture,
    String? description,
    int? points,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return CouponItem(
      id: id ?? this.id,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      description: description ?? this.description,
      points: points ?? this.points,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'picture': picture,
      'description': description,
      'points': points,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
    };
  }

  factory CouponItem.fromMap(Map<String, dynamic> map) {
    return CouponItem(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      picture: map['picture'] ?? '',
      description: map['description'],
      points: map['points']?.toInt(),
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponItem.fromJson(String source) =>
      CouponItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CouponItem(id: $id, name: $name, picture: $picture, description: $description, points: $points, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CouponItem &&
        other.id == id &&
        other.name == name &&
        other.picture == picture &&
        other.description == description &&
        other.points == points &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        picture.hashCode ^
        description.hashCode ^
        points.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
