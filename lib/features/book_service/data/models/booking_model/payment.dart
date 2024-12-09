import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/book_service/enums/payment_status.dart';
import 'package:masaj/features/payment/data/enum/payment_methods.dart';
import 'package:masaj/main.dart';

class Payment {
  int? paymentId;
  String? referenceId;
  PaymentStatus? paymentStatus;
  String? paymentDate;
  PaymentMethodType? paymentMethod;
  Payment({
    this.paymentId,
    this.referenceId,
    this.paymentStatus,
    this.paymentDate,
    this.paymentMethod,
  });
  // 20/02/2023 01:00 PM
  String get formattedDate {
    final date = DateTime.parse(paymentDate!);
    // return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute} ${date.hour > 12 ? 'PM' : 'AM'}';
    // using intl
    final local = EasyLocalization.of(
      navigatorKey!.currentContext!,
    )!
        .currentLocale
        ?.languageCode;
    return DateFormat('dd/MM/yyyy hh:mm a', local).format(date);
  }

  Payment copyWith({
    ValueGetter<int?>? paymentId,
    ValueGetter<String?>? referenceId,
    ValueGetter<PaymentStatus?>? paymentStatus,
    ValueGetter<String?>? paymentDate,
    ValueGetter<PaymentMethodType?>? paymentMethod,
  }) {
    return Payment(
      paymentId: paymentId != null ? paymentId() : this.paymentId,
      referenceId: referenceId != null ? referenceId() : this.referenceId,
      paymentStatus:
          paymentStatus != null ? paymentStatus() : this.paymentStatus,
      paymentDate: paymentDate != null ? paymentDate() : this.paymentDate,
      paymentMethod:
          paymentMethod != null ? paymentMethod() : this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paymentId': paymentId,
      'referenceId': referenceId,
      'paymentStatus': paymentStatus?.index,
      'paymentDate': paymentDate,
      'paymentMethod': paymentMethod?.getIndex,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      paymentId: map['paymentId']?.toInt(),
      referenceId: map['referenceId'],
      paymentStatus: PaymentStatus.values[map['paymentStatus']?.toInt()],
      paymentDate: map['paymentDate'],
      paymentMethod: PaymentMethodType.values[map['paymentMethod'] - 1],
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Payment(paymentId: $paymentId, referenceId: $referenceId, paymentStatus: $paymentStatus, paymentDate: $paymentDate, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payment &&
        other.paymentId == paymentId &&
        other.referenceId == referenceId &&
        other.paymentStatus == paymentStatus &&
        other.paymentDate == paymentDate &&
        other.paymentMethod == paymentMethod;
  }

  @override
  int get hashCode {
    return paymentId.hashCode ^
        referenceId.hashCode ^
        paymentStatus.hashCode ^
        paymentDate.hashCode ^
        paymentMethod.hashCode;
  }
}
