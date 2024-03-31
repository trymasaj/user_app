import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:masaj/features/book_service/enums/payment_status.dart';

class Payment {
  int? paymentId;
  String? referenceId;
  PaymentStatus? paymentStatus;
  String? paymentDate;
  int? paymentMethod;
  Payment({
    this.paymentId,
    this.referenceId,
    this.paymentDate,
    this.paymentMethod,
  });

  Payment copyWith({
    ValueGetter<int?>? paymentId,
    ValueGetter<String?>? referenceId,
    ValueGetter<String?>? paymentDate,
    ValueGetter<int?>? paymentMethod,
  }) {
    return Payment(
      paymentId: paymentId != null ? paymentId() : this.paymentId,
      referenceId: referenceId != null ? referenceId() : this.referenceId,
      paymentDate: paymentDate != null ? paymentDate() : this.paymentDate,
      paymentMethod:
          paymentMethod != null ? paymentMethod() : this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paymentId': paymentId,
      'referenceId': referenceId,
      'paymentDate': paymentDate,
      'paymentMethod': paymentMethod,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      paymentId: map['paymentId']?.toInt(),
      referenceId: map['referenceId'],
      paymentDate: map['paymentDate'],
      paymentMethod: map['paymentMethod']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Payment(paymentId: $paymentId, referenceId: $referenceId, paymentDate: $paymentDate, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payment &&
        other.paymentId == paymentId &&
        other.referenceId == referenceId &&
        other.paymentDate == paymentDate &&
        other.paymentMethod == paymentMethod;
  }

  @override
  int get hashCode {
    return paymentId.hashCode ^
        referenceId.hashCode ^
        paymentDate.hashCode ^
        paymentMethod.hashCode;
  }
}
