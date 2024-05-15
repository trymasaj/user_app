import 'dart:convert';

import 'package:flutter/foundation.dart';

class SubscriptionModel {
  int? id;
  int? customerId;
  int? planId;
  int? paymentMethodId;
  String? started;
  String? endsAt;
  String? paymentDate;
  int? status;
  int? paymentMethod;
  Plan? plan;
  SubscriptionModel({
    this.id,
    this.customerId,
    this.planId,
    this.paymentMethodId,
    this.started,
    this.endsAt,
    this.paymentDate,
    this.status,
    this.paymentMethod,
    this.plan,
  });

  

  SubscriptionModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<int?>? customerId,
    ValueGetter<int?>? planId,
    ValueGetter<int?>? paymentMethodId,
    ValueGetter<String?>? started,
    ValueGetter<String?>? endsAt,
    ValueGetter<String?>? paymentDate,
    ValueGetter<int?>? status,
    ValueGetter<int?>? paymentMethod,
    ValueGetter<Plan?>? plan,
  }) {
    return SubscriptionModel(
      id: id != null ? id() : this.id,
      customerId: customerId != null ? customerId() : this.customerId,
      planId: planId != null ? planId() : this.planId,
      paymentMethodId: paymentMethodId != null ? paymentMethodId() : this.paymentMethodId,
      started: started != null ? started() : this.started,
      endsAt: endsAt != null ? endsAt() : this.endsAt,
      paymentDate: paymentDate != null ? paymentDate() : this.paymentDate,
      status: status != null ? status() : this.status,
      paymentMethod: paymentMethod != null ? paymentMethod() : this.paymentMethod,
      plan: plan != null ? plan() : this.plan,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'planId': planId,
      'paymentMethodId': paymentMethodId,
      'started': started,
      'endsAt': endsAt,
      'paymentDate': paymentDate,
      'status': status,
      'paymentMethod': paymentMethod,
      'plan': plan?.toMap(),
    };
  }

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      id: map['id']?.toInt(),
      customerId: map['customerId']?.toInt(),
      planId: map['planId']?.toInt(),
      paymentMethodId: map['paymentMethodId']?.toInt(),
      started: map['started'],
      endsAt: map['endsAt'],
      paymentDate: map['paymentDate'],
      status: map['status']?.toInt(),
      paymentMethod: map['paymentMethod']?.toInt(),
      plan: map['plan'] != null ? Plan.fromMap(map['plan']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionModel.fromJson(String source) => SubscriptionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubscriptionModel(id: $id, customerId: $customerId, planId: $planId, paymentMethodId: $paymentMethodId, started: $started, endsAt: $endsAt, paymentDate: $paymentDate, status: $status, paymentMethod: $paymentMethod, plan: $plan)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SubscriptionModel &&
      other.id == id &&
      other.customerId == customerId &&
      other.planId == planId &&
      other.paymentMethodId == paymentMethodId &&
      other.started == started &&
      other.endsAt == endsAt &&
      other.paymentDate == paymentDate &&
      other.status == status &&
      other.paymentMethod == paymentMethod &&
      other.plan == plan;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      customerId.hashCode ^
      planId.hashCode ^
      paymentMethodId.hashCode ^
      started.hashCode ^
      endsAt.hashCode ^
      paymentDate.hashCode ^
      status.hashCode ^
      paymentMethod.hashCode ^
      plan.hashCode;
  }
}

class Plan {
  int? id;
  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? descriptionAr;
  String? duration;
  int? price;
  int? discountPercentage;
  int? countryId;
  bool? isActive;
  List<Benefits>? benefits;
  Plan({
    this.id,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.duration,
    this.price,
    this.discountPercentage,
    this.countryId,
    this.isActive,
    this.benefits,
  });


  Plan copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? nameEn,
    ValueGetter<String?>? nameAr,
    ValueGetter<String?>? descriptionEn,
    ValueGetter<String?>? descriptionAr,
    ValueGetter<String?>? duration,
    ValueGetter<int?>? price,
    ValueGetter<int?>? discountPercentage,
    ValueGetter<int?>? countryId,
    ValueGetter<bool?>? isActive,
    ValueGetter<List<Benefits>?>? benefits,
  }) {
    return Plan(
      id: id != null ? id() : this.id,
      nameEn: nameEn != null ? nameEn() : this.nameEn,
      nameAr: nameAr != null ? nameAr() : this.nameAr,
      descriptionEn: descriptionEn != null ? descriptionEn() : this.descriptionEn,
      descriptionAr: descriptionAr != null ? descriptionAr() : this.descriptionAr,
      duration: duration != null ? duration() : this.duration,
      price: price != null ? price() : this.price,
      discountPercentage: discountPercentage != null ? discountPercentage() : this.discountPercentage,
      countryId: countryId != null ? countryId() : this.countryId,
      isActive: isActive != null ? isActive() : this.isActive,
      benefits: benefits != null ? benefits() : this.benefits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'duration': duration,
      'price': price,
      'discountPercentage': discountPercentage,
      'countryId': countryId,
      'isActive': isActive,
      'benefits': benefits?.map((x) => x.toMap()).toList(),
    };
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id']?.toInt(),
      nameEn: map['nameEn'],
      nameAr: map['nameAr'],
      descriptionEn: map['descriptionEn'],
      descriptionAr: map['descriptionAr'],
      duration: map['duration'],
      price: map['price']?.toInt(),
      discountPercentage: map['discountPercentage']?.toInt(),
      countryId: map['countryId']?.toInt(),
      isActive: map['isActive'],
      benefits: map['benefits'] != null ? List<Benefits>.from(map['benefits']?.map((x) => Benefits.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan.fromJson(String source) => Plan.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Plan(id: $id, nameEn: $nameEn, nameAr: $nameAr, descriptionEn: $descriptionEn, descriptionAr: $descriptionAr, duration: $duration, price: $price, discountPercentage: $discountPercentage, countryId: $countryId, isActive: $isActive, benefits: $benefits)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Plan &&
      other.id == id &&
      other.nameEn == nameEn &&
      other.nameAr == nameAr &&
      other.descriptionEn == descriptionEn &&
      other.descriptionAr == descriptionAr &&
      other.duration == duration &&
      other.price == price &&
      other.discountPercentage == discountPercentage &&
      other.countryId == countryId &&
      other.isActive == isActive &&
      listEquals(other.benefits, benefits);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nameEn.hashCode ^
      nameAr.hashCode ^
      descriptionEn.hashCode ^
      descriptionAr.hashCode ^
      duration.hashCode ^
      price.hashCode ^
      discountPercentage.hashCode ^
      countryId.hashCode ^
      isActive.hashCode ^
      benefits.hashCode;
  }
}

class Benefits {
  int? id;
  String? benefitEn;
  String? benefitAr;
  Benefits({
    this.id,
    this.benefitEn,
    this.benefitAr,
  });

  

  Benefits copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? benefitEn,
    ValueGetter<String?>? benefitAr,
  }) {
    return Benefits(
      id: id != null ? id() : this.id,
      benefitEn: benefitEn != null ? benefitEn() : this.benefitEn,
      benefitAr: benefitAr != null ? benefitAr() : this.benefitAr,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'benefitEn': benefitEn,
      'benefitAr': benefitAr,
    };
  }

  factory Benefits.fromMap(Map<String, dynamic> map) {
    return Benefits(
      id: map['id']?.toInt(),
      benefitEn: map['benefitEn'],
      benefitAr: map['benefitAr'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Benefits.fromJson(String source) => Benefits.fromMap(json.decode(source));

  @override
  String toString() => 'Benefits(id: $id, benefitEn: $benefitEn, benefitAr: $benefitAr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Benefits &&
      other.id == id &&
      other.benefitEn == benefitEn &&
      other.benefitAr == benefitAr;
  }

  @override
  int get hashCode => id.hashCode ^ benefitEn.hashCode ^ benefitAr.hashCode;
}
