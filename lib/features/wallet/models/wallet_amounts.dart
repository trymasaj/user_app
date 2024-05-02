import 'dart:convert';

import 'package:flutter/widgets.dart';

class WalletAmountsModel {
  int? id;
  int? amount;
  int? bonusAmount;
  int? totalAmount;
  int? countryId;
  String? currencyEn;
  String? currencyAr;
  String? currency;
  bool? isActive;
  WalletAmountsModel({
    this.id,
    this.amount,
    this.bonusAmount,
    this.totalAmount,
    this.countryId,
    this.currencyEn,
    this.currencyAr,
    this.currency,
    this.isActive,
  });

  WalletAmountsModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<int?>? amount,
    ValueGetter<int?>? bonusAmount,
    ValueGetter<int?>? totalAmount,
    ValueGetter<int?>? countryId,
    ValueGetter<String?>? currencyEn,
    ValueGetter<String?>? currencyAr,
    ValueGetter<String?>? currency,
    ValueGetter<bool?>? isActive,
  }) {
    return WalletAmountsModel(
      id: id != null ? id() : this.id,
      amount: amount != null ? amount() : this.amount,
      bonusAmount: bonusAmount != null ? bonusAmount() : this.bonusAmount,
      totalAmount: totalAmount != null ? totalAmount() : this.totalAmount,
      countryId: countryId != null ? countryId() : this.countryId,
      currencyEn: currencyEn != null ? currencyEn() : this.currencyEn,
      currencyAr: currencyAr != null ? currencyAr() : this.currencyAr,
      currency: currency != null ? currency() : this.currency,
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
      'isActive': isActive,
    };
  }

  factory WalletAmountsModel.fromMap(Map<String, dynamic> map) {
    return WalletAmountsModel(
      id: map['id']?.toInt(),
      amount: map['amount']?.toInt(),
      bonusAmount: map['bonusAmount']?.toInt(),
      totalAmount: map['totalAmount']?.toInt(),
      countryId: map['countryId']?.toInt(),
      currencyEn: map['currencyEn'],
      currencyAr: map['currencyAr'],
      currency: map['currency'],
      isActive: map['isActive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletAmountsModel.fromJson(String source) =>
      WalletAmountsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletModel(id: $id, amount: $amount, bonusAmount: $bonusAmount, totalAmount: $totalAmount, countryId: $countryId, currencyEn: $currencyEn, currencyAr: $currencyAr, currency: $currency, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletAmountsModel &&
        other.id == id &&
        other.amount == amount &&
        other.bonusAmount == bonusAmount &&
        other.totalAmount == totalAmount &&
        other.countryId == countryId &&
        other.currencyEn == currencyEn &&
        other.currencyAr == currencyAr &&
        other.currency == currency &&
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
        isActive.hashCode;
  }
}
