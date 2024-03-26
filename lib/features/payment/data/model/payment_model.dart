import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

class CheckOutModel {
  final ServiceModel? service;
  final Therapist? therapist;
  final Address? address;
  final PaymentSummary? paymentSummary;
  CheckOutModel({
    this.service,
    this.therapist,
    this.address,
    this.paymentSummary,
  });

  CheckOutModel copyWith({
    ValueGetter<ServiceModel?>? service,
    ValueGetter<Therapist?>? therapist,
    ValueGetter<Address?>? address,
    ValueGetter<PaymentSummary?>? paymentSummary,
  }) {
    return CheckOutModel(
      service: service != null ? service() : this.service,
      therapist: therapist != null ? therapist() : this.therapist,
      address: address != null ? address() : this.address,
      paymentSummary:
          paymentSummary != null ? paymentSummary() : this.paymentSummary,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'service': service?.toMap(),
      'therapist': therapist?.toMap(),
      'address': address?.toMap(),
      'paymentSummary': paymentSummary?.toMap(),
    };
  }

  factory CheckOutModel.fromMap(Map<String, dynamic> map) {
    return CheckOutModel(
      service:
          map['service'] != null ? ServiceModel.fromMap(map['service']) : null,
      therapist:
          map['therapist'] != null ? Therapist.fromMap(map['therapist']) : null,
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      paymentSummary: map['paymentSummary'] != null
          ? PaymentSummary.fromMap(map['paymentSummary'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckOutModel.fromJson(String source) =>
      CheckOutModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CheckOutModel(service: $service, therapist: $therapist, address: $address, paymentSummary: $paymentSummary)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CheckOutModel &&
        other.service == service &&
        other.therapist == therapist &&
        other.address == address &&
        other.paymentSummary == paymentSummary;
  }

  @override
  int get hashCode {
    return service.hashCode ^
        therapist.hashCode ^
        address.hashCode ^
        paymentSummary.hashCode;
  }
}

class PaymentSummary {
  final double? subTotal;
  final double? discount;
  PaymentSummary({
    this.subTotal,
    this.discount,
  });

  PaymentSummary copyWith({
    ValueGetter<double?>? subTotal,
    ValueGetter<double?>? discount,
  }) {
    return PaymentSummary(
      subTotal: subTotal != null ? subTotal() : this.subTotal,
      discount: discount != null ? discount() : this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subTotal': subTotal,
      'discount': discount,
    };
  }

  factory PaymentSummary.fromMap(Map<String, dynamic> map) {
    return PaymentSummary(
      subTotal: map['subTotal']?.toDouble(),
      discount: map['discount']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentSummary.fromJson(String source) =>
      PaymentSummary.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentSummary(subTotal: $subTotal, discount: $discount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentSummary &&
        other.subTotal == subTotal &&
        other.discount == discount;
  }

  @override
  int get hashCode => subTotal.hashCode ^ discount.hashCode;
}
