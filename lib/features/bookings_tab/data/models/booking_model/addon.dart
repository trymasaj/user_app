import 'dart:convert';

import 'package:collection/collection.dart';

class Addon {
  int? addonId;
  int? serviceId;
  int? countryId;
  String? titleEn;
  String? titleAr;
  String? descriptionEn;
  String? descriptionAr;
  String? duration;
  int? price;

  Addon({
    this.addonId,
    this.serviceId,
    this.countryId,
    this.titleEn,
    this.titleAr,
    this.descriptionEn,
    this.descriptionAr,
    this.duration,
    this.price,
  });

  @override
  String toString() {
    return 'Addon(addonId: $addonId, serviceId: $serviceId, countryId: $countryId, titleEn: $titleEn, titleAr: $titleAr, descriptionEn: $descriptionEn, descriptionAr: $descriptionAr, duration: $duration, price: $price)';
  }

  factory Addon.fromMap(Map<String, dynamic> data) => Addon(
        addonId: data['addonId'] as int?,
        serviceId: data['serviceId'] as int?,
        countryId: data['countryId'] as int?,
        titleEn: data['titleEn'] as String?,
        titleAr: data['titleAr'] as String?,
        descriptionEn: data['descriptionEn'] as String?,
        descriptionAr: data['descriptionAr'] as String?,
        duration: data['duration'] as String?,
        price: data['price'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'addonId': addonId,
        'serviceId': serviceId,
        'countryId': countryId,
        'titleEn': titleEn,
        'titleAr': titleAr,
        'descriptionEn': descriptionEn,
        'descriptionAr': descriptionAr,
        'duration': duration,
        'price': price,
      };

  factory Addon.fromJson(String data) {
    return Addon.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  String toJson() => json.encode(toMap());

  Addon copyWith({
    int? addonId,
    int? serviceId,
    int? countryId,
    String? titleEn,
    String? titleAr,
    String? descriptionEn,
    String? descriptionAr,
    String? duration,
    int? price,
  }) {
    return Addon(
      addonId: addonId ?? this.addonId,
      serviceId: serviceId ?? this.serviceId,
      countryId: countryId ?? this.countryId,
      titleEn: titleEn ?? this.titleEn,
      titleAr: titleAr ?? this.titleAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      duration: duration ?? this.duration,
      price: price ?? this.price,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Addon) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      addonId.hashCode ^
      serviceId.hashCode ^
      countryId.hashCode ^
      titleEn.hashCode ^
      titleAr.hashCode ^
      descriptionEn.hashCode ^
      descriptionAr.hashCode ^
      duration.hashCode ^
      price.hashCode;
}
