import 'dart:convert';

import 'package:collection/collection.dart';

import 'addon.dart';

class Service {
  int? id;
  int? serviceCategoryId;
  int? countryId;
  String? titleEn;
  String? titleAr;
  String? descriptionEn;
  String? descriptionAr;
  bool? allowFocusAreas;
  int? sortKey;
  int? durationId;
  String? duration;
  int? price;
  List<Addon>? addons;

  Service({
    this.id,
    this.serviceCategoryId,
    this.countryId,
    this.titleEn,
    this.titleAr,
    this.descriptionEn,
    this.descriptionAr,
    this.allowFocusAreas,
    this.sortKey,
    this.durationId,
    this.duration,
    this.price,
    this.addons,
  });

  @override
  String toString() {
    return 'Service(id: $id, serviceCategoryId: $serviceCategoryId, countryId: $countryId, titleEn: $titleEn, titleAr: $titleAr, descriptionEn: $descriptionEn, descriptionAr: $descriptionAr, allowFocusAreas: $allowFocusAreas, sortKey: $sortKey, durationId: $durationId, duration: $duration, price: $price, addons: $addons)';
  }

  factory Service.fromMap(Map<String, dynamic> data) => Service(
        id: data['id'] as int?,
        serviceCategoryId: data['serviceCategoryId'] as int?,
        countryId: data['countryId'] as int?,
        titleEn: data['titleEn'] as String?,
        titleAr: data['titleAr'] as String?,
        descriptionEn: data['descriptionEn'] as String?,
        descriptionAr: data['descriptionAr'] as String?,
        allowFocusAreas: data['allowFocusAreas'] as bool?,
        sortKey: data['sortKey'] as int?,
        durationId: data['durationId'] as int?,
        duration: data['duration'] as String?,
        price: data['price'] as int?,
        addons: (data['addons'] as List<dynamic>?)
            ?.map((e) => Addon.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'serviceCategoryId': serviceCategoryId,
        'countryId': countryId,
        'titleEn': titleEn,
        'titleAr': titleAr,
        'descriptionEn': descriptionEn,
        'descriptionAr': descriptionAr,
        'allowFocusAreas': allowFocusAreas,
        'sortKey': sortKey,
        'durationId': durationId,
        'duration': duration,
        'price': price,
        'addons': addons?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Service].
  factory Service.fromJson(String data) {
    return Service.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Service] to a JSON string.
  String toJson() => json.encode(toMap());

  Service copyWith({
    int? id,
    int? serviceCategoryId,
    int? countryId,
    String? titleEn,
    String? titleAr,
    String? descriptionEn,
    String? descriptionAr,
    bool? allowFocusAreas,
    int? sortKey,
    int? durationId,
    String? duration,
    int? price,
    List<Addon>? addons,
  }) {
    return Service(
      id: id ?? this.id,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      countryId: countryId ?? this.countryId,
      titleEn: titleEn ?? this.titleEn,
      titleAr: titleAr ?? this.titleAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      allowFocusAreas: allowFocusAreas ?? this.allowFocusAreas,
      sortKey: sortKey ?? this.sortKey,
      durationId: durationId ?? this.durationId,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      addons: addons ?? this.addons,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Service) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      serviceCategoryId.hashCode ^
      countryId.hashCode ^
      titleEn.hashCode ^
      titleAr.hashCode ^
      descriptionEn.hashCode ^
      descriptionAr.hashCode ^
      allowFocusAreas.hashCode ^
      sortKey.hashCode ^
      durationId.hashCode ^
      duration.hashCode ^
      price.hashCode ^
      addons.hashCode;
}
