import 'dart:convert';
import 'package:flutter/foundation.dart';

class WalletModel {
  String? currencyEn;
  String? currencyAr;
  String? currency;
  int? balance;
  List<WalletTransactionHistory>? walletTransactionHistory;

  WalletModel({
    this.currencyEn,
    this.currencyAr,
    this.currency,
    this.balance,
    this.walletTransactionHistory,
  });

  WalletModel copyWith({
    ValueGetter<String?>? currencyEn,
    ValueGetter<String?>? currencyAr,
    ValueGetter<String?>? currency,
    ValueGetter<int?>? balance,
    ValueGetter<List<WalletTransactionHistory>?>? walletTransactionHistory,
  }) {
    return WalletModel(
      currencyEn: currencyEn != null ? currencyEn() : this.currencyEn,
      currencyAr: currencyAr != null ? currencyAr() : this.currencyAr,
      currency: currency != null ? currency() : this.currency,
      balance: balance != null ? balance() : this.balance,
      walletTransactionHistory: walletTransactionHistory != null
          ? walletTransactionHistory()
          : this.walletTransactionHistory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currencyEn': currencyEn,
      'currencyAr': currencyAr,
      'currency': currency,
      'balance': balance,
      'walletTransactionHistory':
          walletTransactionHistory?.map((x) => x.toMap()).toList(),
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      currencyEn: map['currencyEn'],
      currencyAr: map['currencyAr'],
      currency: map['currency'],
      balance: map['balance']?.toInt(),
      walletTransactionHistory: map['walletTransactionHistory'] != null
          ? List<WalletTransactionHistory>.from(map['walletTransactionHistory']
              ?.map((x) => WalletTransactionHistory.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletModel(currencyEn: $currencyEn, currencyAr: $currencyAr, currency: $currency, balance: $balance, walletTransactionHistory: $walletTransactionHistory)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletModel &&
        other.currencyEn == currencyEn &&
        other.currencyAr == currencyAr &&
        other.currency == currency &&
        other.balance == balance &&
        listEquals(other.walletTransactionHistory, walletTransactionHistory);
  }

  @override
  int get hashCode {
    return currencyEn.hashCode ^
        currencyAr.hashCode ^
        currency.hashCode ^
        balance.hashCode ^
        walletTransactionHistory.hashCode;
  }
}

class WalletTransactionHistory {
  int? credit;
  int? debit;
  int? balance;
  String? transactionReason;
  String? transactionDate;
  int? transactionType;
  WalletTransactionHistory({
    this.credit,
    this.debit,
    this.balance,
    this.transactionReason,
    this.transactionDate,
    this.transactionType,
  });

  WalletTransactionHistory copyWith({
    ValueGetter<int?>? credit,
    ValueGetter<int?>? debit,
    ValueGetter<int?>? balance,
    ValueGetter<String?>? transactionReason,
    ValueGetter<String?>? transactionDate,
    ValueGetter<int?>? transactionType,
  }) {
    return WalletTransactionHistory(
      credit: credit != null ? credit() : this.credit,
      debit: debit != null ? debit() : this.debit,
      balance: balance != null ? balance() : this.balance,
      transactionReason: transactionReason != null
          ? transactionReason()
          : this.transactionReason,
      transactionDate:
          transactionDate != null ? transactionDate() : this.transactionDate,
      transactionType:
          transactionType != null ? transactionType() : this.transactionType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'credit': credit,
      'debit': debit,
      'balance': balance,
      'transactionReason': transactionReason,
      'transactionDate': transactionDate,
      'transactionType': transactionType,
    };
  }

  factory WalletTransactionHistory.fromMap(Map<String, dynamic> map) {
    return WalletTransactionHistory(
      credit: map['credit']?.toInt(),
      debit: map['debit']?.toInt(),
      balance: map['balance']?.toInt(),
      transactionReason: map['transactionReason'],
      transactionDate: map['transactionDate'],
      transactionType: map['transactionType']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletTransactionHistory.fromJson(String source) =>
      WalletTransactionHistory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletTransactionHistory(credit: $credit, debit: $debit, balance: $balance, transactionReason: $transactionReason, transactionDate: $transactionDate, transactionType: $transactionType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletTransactionHistory &&
        other.credit == credit &&
        other.debit == debit &&
        other.balance == balance &&
        other.transactionReason == transactionReason &&
        other.transactionDate == transactionDate &&
        other.transactionType == transactionType;
  }

  @override
  int get hashCode {
    return credit.hashCode ^
        debit.hashCode ^
        balance.hashCode ^
        transactionReason.hashCode ^
        transactionDate.hashCode ^
        transactionType.hashCode;
  }
}
