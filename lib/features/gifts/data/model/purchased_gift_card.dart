import 'dart:convert';

import 'package:flutter/widgets.dart';

class PurchasedGiftCard {
  int? id;
  int? amount;
  int? bonusAmount;
  int? totalAmount;
  int? countryId;
  String? currencyEn;
  String? currencyAr;
  String? currency;
  String? imageColor;
  bool? isActive;
  String? redemptionCode;
  int? status;
  String? redemptionDate;
  String? purchaseDate;
  int? buyerId;
  int? redeemerId;
  PurchasedGiftCard({
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
    this.redemptionCode,
    this.status,
    this.redemptionDate,
    this.purchaseDate,
    this.buyerId,
    this.redeemerId,
  });

  PurchasedGiftCard copyWith({
    ValueGetter<int?>? id,
    ValueGetter<int?>? amount,
    ValueGetter<int?>? bonusAmount,
    ValueGetter<int?>? totalAmount,
    ValueGetter<int?>? countryId,
    ValueGetter<String?>? currencyEn,
    ValueGetter<String?>? currencyAr,
    ValueGetter<String?>? currency,
    ValueGetter<String?>? imageColor,
    ValueGetter<bool?>? isActive,
    ValueGetter<String?>? redemptionCode,
    ValueGetter<int?>? status,
    ValueGetter<String?>? redemptionDate,
    ValueGetter<String?>? purchaseDate,
    ValueGetter<int?>? buyerId,
    ValueGetter<int?>? redeemerId,
  }) {
    return PurchasedGiftCard(
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
      redemptionCode:
          redemptionCode != null ? redemptionCode() : this.redemptionCode,
      status: status != null ? status() : this.status,
      redemptionDate:
          redemptionDate != null ? redemptionDate() : this.redemptionDate,
      purchaseDate: purchaseDate != null ? purchaseDate() : this.purchaseDate,
      buyerId: buyerId != null ? buyerId() : this.buyerId,
      redeemerId: redeemerId != null ? redeemerId() : this.redeemerId,
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
      'imageColor': imageColor,
      'isActive': isActive,
      'redemptionCode': redemptionCode,
      'status': status,
      'redemptionDate': redemptionDate,
      'purchaseDate': purchaseDate,
      'buyerId': buyerId,
      'redeemerId': redeemerId,
    };
  }

  factory PurchasedGiftCard.fromMap(Map<String, dynamic> map) {
    return PurchasedGiftCard(
      id: map['id']?.toInt(),
      amount: map['amount']?.toInt(),
      bonusAmount: map['bonusAmount']?.toInt(),
      totalAmount: map['totalAmount']?.toInt(),
      countryId: map['countryId']?.toInt(),
      currencyEn: map['currencyEn'],
      currencyAr: map['currencyAr'],
      currency: map['currency'],
      imageColor: map['imageColor'],
      isActive: map['isActive'],
      redemptionCode: map['redemptionCode'],
      status: map['status']?.toInt(),
      redemptionDate: map['redemptionDate'],
      purchaseDate: map['purchaseDate'],
      buyerId: map['buyerId']?.toInt(),
      redeemerId: map['redeemerId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchasedGiftCard.fromJson(String source) =>
      PurchasedGiftCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PurchasedGiftCard(id: $id, amount: $amount, bonusAmount: $bonusAmount, totalAmount: $totalAmount, countryId: $countryId, currencyEn: $currencyEn, currencyAr: $currencyAr, currency: $currency, imageColor: $imageColor, isActive: $isActive, redemptionCode: $redemptionCode, status: $status, redemptionDate: $redemptionDate, purchaseDate: $purchaseDate, buyerId: $buyerId, redeemerId: $redeemerId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PurchasedGiftCard &&
        other.id == id &&
        other.amount == amount &&
        other.bonusAmount == bonusAmount &&
        other.totalAmount == totalAmount &&
        other.countryId == countryId &&
        other.currencyEn == currencyEn &&
        other.currencyAr == currencyAr &&
        other.currency == currency &&
        other.imageColor == imageColor &&
        other.isActive == isActive &&
        other.redemptionCode == redemptionCode &&
        other.status == status &&
        other.redemptionDate == redemptionDate &&
        other.purchaseDate == purchaseDate &&
        other.buyerId == buyerId &&
        other.redeemerId == redeemerId;
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
        isActive.hashCode ^
        redemptionCode.hashCode ^
        status.hashCode ^
        redemptionDate.hashCode ^
        purchaseDate.hashCode ^
        buyerId.hashCode ^
        redeemerId.hashCode;
  }
}
