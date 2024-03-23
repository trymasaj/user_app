import 'dart:convert';

import 'package:flutter/widgets.dart';

class PaymentMethodModel {
  final int? id;
  final String? url;
  final String? logo;
  final String? name;
  bool isSelected;
  PaymentMethodModel({
    this.id,
    this.url,
    this.logo,
    this.name,
    this.isSelected = false,
  });

  PaymentMethodModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? url,
    ValueGetter<String?>? logo,
    ValueGetter<String?>? name,
    ValueGetter<bool>? isSelected,
  }) {
    return PaymentMethodModel(
      id: id != null ? id() : this.id,
      url: url != null ? url() : this.url,
      logo: logo != null ? logo() : this.logo,
      name: name != null ? name() : this.name,
      isSelected: isSelected != null ? isSelected() : this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'logo': logo,
      'name': name,
      'isSelected': isSelected,
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      id: map['id']?.toInt(),
      url: map['url'],
      logo: map['logo'],
      name: map['name'],
      isSelected: map['isSelected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodModel.fromJson(String source) =>
      PaymentMethodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentMethodModel(id: $id, url: $url, logo: $logo, name: $name, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethodModel &&
        other.id == id &&
        other.url == url &&
        other.logo == logo &&
        other.name == name &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        url.hashCode ^
        logo.hashCode ^
        name.hashCode ^
        isSelected.hashCode;
  }
}
