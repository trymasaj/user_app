import 'dart:convert';

import 'package:flutter/foundation.dart';

class RedeemGiftCard {
  int? status;
  String? title;
  String? detail;
  List<String>? errors;
  RedeemGiftCard({
    this.status,
    this.title,
    this.detail,
    this.errors,
  });

  RedeemGiftCard copyWith({
    ValueGetter<int?>? status,
    ValueGetter<String?>? title,
    ValueGetter<String?>? detail,
    ValueGetter<List<String>?>? errors,
  }) {
    return RedeemGiftCard(
      status: status != null ? status() : this.status,
      title: title != null ? title() : this.title,
      detail: detail != null ? detail() : this.detail,
      errors: errors != null ? errors() : this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'title': title,
      'detail': detail,
      'errors': errors,
    };
  }

  factory RedeemGiftCard.fromMap(Map<String, dynamic> map) {
    return RedeemGiftCard(
      status: map['status']?.toInt(),
      title: map['title'],
      detail: map['detail'],
      errors: List<String>.from(map['errors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RedeemGiftCard.fromJson(String source) =>
      RedeemGiftCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReedemGiftCard(status: $status, title: $title, detail: $detail, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RedeemGiftCard &&
        other.status == status &&
        other.title == title &&
        other.detail == detail &&
        listEquals(other.errors, errors);
  }

  @override
  int get hashCode {
    return status.hashCode ^ title.hashCode ^ detail.hashCode ^ errors.hashCode;
  }
}
