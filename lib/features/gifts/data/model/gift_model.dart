import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GiftModel {
  int? id;
  int? amount;
  int? bonusAmount;
  int? totalAmount;
  int? countryId;
  String? currencyEn;
  String? currencyAr;
  String? currency;
  Color? imageColor;
  bool? isActive;
  GiftModel({
    this.id,
    this.amount,
    this.bonusAmount,
    this.totalAmount,
    this.countryId,
    this.currencyEn,
    this.currencyAr,
    this.currency,
    this.imageColor,
    this.isActive,
  });

  GiftModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<int?>? amount,
    ValueGetter<int?>? bonusAmount,
    ValueGetter<int?>? totalAmount,
    ValueGetter<int?>? countryId,
    ValueGetter<String?>? currencyEn,
    ValueGetter<String?>? currencyAr,
    ValueGetter<String?>? currency,
    ValueGetter<Color?>? imageColor,
    ValueGetter<bool?>? isActive,
  }) {
    return GiftModel(
      id: id != null ? id() : this.id,
      amount: amount != null ? amount() : this.amount,
      bonusAmount: bonusAmount != null ? bonusAmount() : this.bonusAmount,
      totalAmount: totalAmount != null ? totalAmount() : this.totalAmount,
      countryId: countryId != null ? countryId() : this.countryId,
      currencyEn: currencyEn != null ? currencyEn() : this.currencyEn,
      currencyAr: currencyAr != null ? currencyAr() : this.currencyAr,
      currency: currency != null ? currency() : this.currency,
      imageColor: imageColor != null ? imageColor() : this.imageColor,
      isActive: isActive != null ? isActive() : this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'bonusAmount': bonusAmount,
      'totalAmount': totalAmount,
      'countryId': countryId,
      'currencyEn': currencyEn,
      'currencyAr': currencyAr,
      'currency': currency,
      'imageColor': imageColor?.value,
      'isActive': isActive,
    };
  }

  factory GiftModel.fromMap(Map<String, dynamic> map) {
    return GiftModel(
      id: map['id']?.toInt(),
      amount: map['amount']?.toInt(),
      bonusAmount: map['bonusAmount']?.toInt(),
      totalAmount: map['totalAmount']?.toInt(),
      countryId: map['countryId']?.toInt(),
      currencyEn: map['currencyEn'],
      currencyAr: map['currencyAr'],
      currency: map['currency'],
      imageColor:
          map['imageColor'] != null ? hexToColor(map['imageColor']) : null,
      isActive: map['isActive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GiftModel.fromJson(String source) =>
      GiftModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GiftModel(id: $id, amount: $amount, bonusAmount: $bonusAmount, totalAmount: $totalAmount, countryId: $countryId, currencyEn: $currencyEn, currencyAr: $currencyAr, currency: $currency, imageColor: $imageColor, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GiftModel &&
        other.id == id &&
        other.amount == amount &&
        other.bonusAmount == bonusAmount &&
        other.totalAmount == totalAmount &&
        other.countryId == countryId &&
        other.currencyEn == currencyEn &&
        other.currencyAr == currencyAr &&
        other.currency == currency &&
        other.imageColor == imageColor &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        bonusAmount.hashCode ^
        totalAmount.hashCode ^
        countryId.hashCode ^
        currencyEn.hashCode ^
        currencyAr.hashCode ^
        currency.hashCode ^
        imageColor.hashCode ^
        isActive.hashCode;
  }
}

/// Construct a color from a hex code string, of the format #RRGGBB.
Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
