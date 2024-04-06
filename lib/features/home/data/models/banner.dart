// {
//     "id": 3,
//     "name": "Therapist Banner",
//     "imageUrlEn": "https://masaj-s3.fra1.cdn.digitaloceanspaces.com/banner-images/a31e5856-761a-4b8f-9ee2-9a890502da14.jpg",
//     "imageUrlAr": "https://masaj-s3.fra1.cdn.digitaloceanspaces.com/banner-images/3dcb703f-24cc-4893-98c3-c923f58a8643.jpg",
//     "navigationType": 2,
//     "isActive": true,
//     "sortId": 0,
//     "countryId": 1,
//     "therapistId": 1,
//     "serviceId": null,
//     "sectionId": null
//   },
// create model

import 'dart:convert';

enum BannerNavigationType {
  service,
  section,
  therapist,
  
  unknown,
}
extension BannerNavigationTypeExtension on BannerModel {
  bool get isService => navigationType == BannerNavigationType.service;
  bool get isSection => navigationType == BannerNavigationType.section;
  bool get isTherapist => navigationType == BannerNavigationType.therapist;
  bool get isUnknown => navigationType == BannerNavigationType.unknown;
  
}


class BannerModel {
  BannerModel({
    this.id,
    this.name,
    this.imageUrlEn,
    this.imageUrlAr,
    this.navigationType,
    this.isActive,
    this.sortId,
    this.countryId,
    this.therapistId,
    this.serviceId,
    this.sectionId,
  });

  final int? id;
  final String? name;
  final String? imageUrlEn;
  final String? imageUrlAr;
  final BannerNavigationType? navigationType;
  final bool? isActive;
  final int? sortId;
  final int? countryId;
  final int? therapistId;
  final int? serviceId;
  final int? sectionId;

  BannerModel copyWith({
    int? id,
    String? name,
    String? imageUrlEn,
    String? imageUrlAr,
    BannerNavigationType? navigationType,
    bool? isActive,
    int? sortId,
    int? countryId,
    int? therapistId,
    int? serviceId,
    int? sectionId,
  }) {
    return BannerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrlEn: imageUrlEn ?? this.imageUrlEn,
      imageUrlAr: imageUrlAr ?? this.imageUrlAr,
      navigationType: navigationType ?? this.navigationType,
      isActive: isActive ?? this.isActive,
      sortId: sortId ?? this.sortId,
      countryId: countryId ?? this.countryId,
      therapistId: therapistId ?? this.therapistId,
      serviceId: serviceId ?? this.serviceId,
      sectionId: sectionId ?? this.sectionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrlEn': imageUrlEn,
      'imageUrlAr': imageUrlAr,
      'navigationType': navigationType?.index,
      'isActive': isActive,
      'sortId': sortId,
      'countryId': countryId,
      'therapistId': therapistId,
      'serviceId': serviceId,
      'sectionId': sectionId,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      imageUrlEn: map['imageUrlEn'] as String?,
      imageUrlAr: map['imageUrlAr'] as String?,
      navigationType: map['navigationType'] != null
          ? BannerNavigationType.values[map['navigationType'] as int]
          : BannerNavigationType.unknown,
      isActive: map['isActive'] as bool?,
      sortId: map['sortId'] as int?,
      countryId: map['countryId'] as int?,
      therapistId: map['therapistId'] as int?,
      serviceId: map['serviceId'],
      sectionId: map['sectionId'],
    );
  }
  // from json
  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);
  // to json
  String toJson() => json.encode(toMap());

  // copy with
  @override
  String toString() {
    return 'Banner(id: $id, name: $name, imageUrlEn: $imageUrlEn, imageUrlAr: $imageUrlAr, navigationType: $navigationType, isActive: $isActive, sortId: $sortId, countryId: $countryId, therapistId: $therapistId, serviceId: $serviceId, sectionId: $sectionId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannerModel &&
        other.id == id &&
        other.name == name &&
        other.imageUrlEn == imageUrlEn &&
        other.imageUrlAr == imageUrlAr &&
        other.navigationType == navigationType &&
        other.isActive == isActive &&
        other.sortId == sortId &&
        other.countryId == countryId &&
        other.therapistId == therapistId &&
        other.serviceId == serviceId &&
        other.sectionId == sectionId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrlEn.hashCode ^
        imageUrlAr.hashCode ^
        navigationType.hashCode ^
        isActive.hashCode ^
        sortId.hashCode ^
        countryId.hashCode ^
        therapistId.hashCode ^
        serviceId.hashCode ^
        sectionId.hashCode;
  }

  // copy with
}
