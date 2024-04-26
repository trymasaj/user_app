import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GiftModel {
  int? id;
  String? shareCode;
  double? amount;
  Color? color;
  GiftModel({
    this.id,
    this.shareCode,
    this.amount,
    this.color,
  });

  GiftModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? shareCode,
    ValueGetter<double?>? amount,
    ValueGetter<Color?>? color,
  }) {
    return GiftModel(
      id: id != null ? id() : this.id,
      shareCode: shareCode != null ? shareCode() : this.shareCode,
      amount: amount != null ? amount() : this.amount,
      color: color != null ? color() : this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shareCode': shareCode,
      'amount': amount,
      'color': color?.value,
    };
  }

  factory GiftModel.fromMap(Map<String, dynamic> map) {
    return GiftModel(
      id: map['id']?.toInt(),
      shareCode: map['shareCode'],
      amount: map['amount']?.toDouble(),
      color: map['color'] != null ? Color(map['color']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GiftModel.fromJson(String source) =>
      GiftModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GiftModel(id: $id, shareCode: $shareCode, amount: $amount, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GiftModel &&
        other.id == id &&
        other.shareCode == shareCode &&
        other.amount == amount &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^ shareCode.hashCode ^ amount.hashCode ^ color.hashCode;
  }
}
