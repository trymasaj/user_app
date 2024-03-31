import 'dart:convert';

import 'package:flutter/widgets.dart';

class PaymentMethodModel {
  final int? id;
  final String? titleAr;
  final String? titleEn;
  final String? title;
  bool isSelected;
  PaymentMethodModel({
    this.id,
    this.titleAr,
    this.titleEn,
    this.title,
    required this.isSelected,
  });

  PaymentMethodModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? titleAr,
    ValueGetter<String?>? titleEn,
    ValueGetter<String?>? title,
    bool? isSelected,
  }) {
    return PaymentMethodModel(
      id: id != null ? id() : this.id,
      titleAr: titleAr != null ? titleAr() : this.titleAr,
      titleEn: titleEn != null ? titleEn() : this.titleEn,
      title: title != null ? title() : this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titleAr': titleAr,
      'titleEn': titleEn,
      'title': title,
      'isSelected': isSelected,
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      id: map['id']?.toInt(),
      titleAr: map['titleAr'],
      titleEn: map['titleEn'],
      title: map['title'],
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodModel.fromJson(String source) =>
      PaymentMethodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentMethodModel(id: $id, titleAr: $titleAr, titleEn: $titleEn, title: $title, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethodModel &&
        other.id == id &&
        other.titleAr == titleAr &&
        other.titleEn == titleEn &&
        other.title == title &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        titleAr.hashCode ^
        titleEn.hashCode ^
        title.hashCode ^
        isSelected.hashCode;
  }
}
