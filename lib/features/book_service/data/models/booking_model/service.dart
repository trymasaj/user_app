import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'addon.dart';

class Service {
  int? id;
  int? serviceCategoryId;
  int? countryId;
  String? titleEn;
  String? titleAr;
  String? title;
  String? descriptionEn;
  String? descriptionAr;
  String? description;
  String? mediaUrlEn;
  String? mediaUrlAr;
  String? mediaUrl;
  bool? allowFocusAreas;
  int? sortKey;
  int? durationId;
  String? duration;
  int? price;
  List<Media>? media;
  List<Addon>? addons;
  Service({
    this.id,
    this.serviceCategoryId,
    this.countryId,
    this.titleEn,
    this.titleAr,
    this.title,
    this.descriptionEn,
    this.descriptionAr,
    this.description,
    this.mediaUrlEn,
    this.mediaUrlAr,
    this.mediaUrl,
    this.allowFocusAreas,
    this.sortKey,
    this.durationId,
    this.duration,
    this.price,
    this.media,
    this.addons,
  });

  Service copyWith({
    ValueGetter<int?>? id,
    ValueGetter<int?>? serviceCategoryId,
    ValueGetter<int?>? countryId,
    ValueGetter<String?>? titleEn,
    ValueGetter<String?>? titleAr,
    ValueGetter<String?>? title,
    ValueGetter<String?>? descriptionEn,
    ValueGetter<String?>? descriptionAr,
    ValueGetter<String?>? description,
    ValueGetter<String?>? mediaUrlEn,
    ValueGetter<String?>? mediaUrlAr,
    ValueGetter<String?>? mediaUrl,
    ValueGetter<bool?>? allowFocusAreas,
    ValueGetter<int?>? sortKey,
    ValueGetter<int?>? durationId,
    ValueGetter<String?>? duration,
    ValueGetter<int?>? price,
    ValueGetter<List<Media>?>? media,
    ValueGetter<List<Addon>?>? addons,
  }) {
    return Service(
      id: id != null ? id() : this.id,
      serviceCategoryId: serviceCategoryId != null
          ? serviceCategoryId()
          : this.serviceCategoryId,
      countryId: countryId != null ? countryId() : this.countryId,
      titleEn: titleEn != null ? titleEn() : this.titleEn,
      titleAr: titleAr != null ? titleAr() : this.titleAr,
      title: title != null ? title() : this.title,
      descriptionEn:
          descriptionEn != null ? descriptionEn() : this.descriptionEn,
      descriptionAr:
          descriptionAr != null ? descriptionAr() : this.descriptionAr,
      description: description != null ? description() : this.description,
      mediaUrlEn: mediaUrlEn != null ? mediaUrlEn() : this.mediaUrlEn,
      mediaUrlAr: mediaUrlAr != null ? mediaUrlAr() : this.mediaUrlAr,
      mediaUrl: mediaUrl != null ? mediaUrl() : this.mediaUrl,
      allowFocusAreas:
          allowFocusAreas != null ? allowFocusAreas() : this.allowFocusAreas,
      sortKey: sortKey != null ? sortKey() : this.sortKey,
      durationId: durationId != null ? durationId() : this.durationId,
      duration: duration != null ? duration() : this.duration,
      price: price != null ? price() : this.price,
      media: media != null ? media() : this.media,
      addons: addons != null ? addons() : this.addons,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serviceCategoryId': serviceCategoryId,
      'countryId': countryId,
      'titleEn': titleEn,
      'titleAr': titleAr,
      'title': title,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'description': description,
      'mediaUrlEn': mediaUrlEn,
      'mediaUrlAr': mediaUrlAr,
      'mediaUrl': mediaUrl,
      'allowFocusAreas': allowFocusAreas,
      'sortKey': sortKey,
      'durationId': durationId,
      'duration': duration,
      'price': price,
      'media': media?.map((x) => x?.toMap())?.toList(),
      'addons': addons?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id']?.toInt(),
      serviceCategoryId: map['serviceCategoryId']?.toInt(),
      countryId: map['countryId']?.toInt(),
      titleEn: map['titleEn'],
      titleAr: map['titleAr'],
      title: map['title'],
      descriptionEn: map['descriptionEn'],
      descriptionAr: map['descriptionAr'],
      description: map['description'],
      mediaUrlEn: map['mediaUrlEn'],
      mediaUrlAr: map['mediaUrlAr'],
      mediaUrl: map['mediaUrl'],
      allowFocusAreas: map['allowFocusAreas'],
      sortKey: map['sortKey']?.toInt(),
      durationId: map['durationId']?.toInt(),
      duration: map['duration'],
      price: map['price']?.toInt(),
      media: map['media'] != null
          ? List<Media>.from(map['media']?.map((x) => Media.fromMap(x)))
          : null,
      addons: map['addons'] != null
          ? List<Addon>.from(map['addons']?.map((x) => Addon.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Service(id: $id, serviceCategoryId: $serviceCategoryId, countryId: $countryId, titleEn: $titleEn, titleAr: $titleAr, title: $title, descriptionEn: $descriptionEn, descriptionAr: $descriptionAr, description: $description, mediaUrlEn: $mediaUrlEn, mediaUrlAr: $mediaUrlAr, mediaUrl: $mediaUrl, allowFocusAreas: $allowFocusAreas, sortKey: $sortKey, durationId: $durationId, duration: $duration, price: $price, media: $media, addons: $addons)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service &&
        other.id == id &&
        other.serviceCategoryId == serviceCategoryId &&
        other.countryId == countryId &&
        other.titleEn == titleEn &&
        other.titleAr == titleAr &&
        other.title == title &&
        other.descriptionEn == descriptionEn &&
        other.descriptionAr == descriptionAr &&
        other.description == description &&
        other.mediaUrlEn == mediaUrlEn &&
        other.mediaUrlAr == mediaUrlAr &&
        other.mediaUrl == mediaUrl &&
        other.allowFocusAreas == allowFocusAreas &&
        other.sortKey == sortKey &&
        other.durationId == durationId &&
        other.duration == duration &&
        other.price == price &&
        listEquals(other.media, media) &&
        listEquals(other.addons, addons);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serviceCategoryId.hashCode ^
        countryId.hashCode ^
        titleEn.hashCode ^
        titleAr.hashCode ^
        title.hashCode ^
        descriptionEn.hashCode ^
        descriptionAr.hashCode ^
        description.hashCode ^
        mediaUrlEn.hashCode ^
        mediaUrlAr.hashCode ^
        mediaUrl.hashCode ^
        allowFocusAreas.hashCode ^
        sortKey.hashCode ^
        durationId.hashCode ^
        duration.hashCode ^
        price.hashCode ^
        media.hashCode ^
        addons.hashCode;
  }
}

class Media {
  int? mediaId;
  bool? isMain;
  String? mediaUrlEn;
  String? mediaUrlAr;
  String? mediaUrl;
  int? mediaType;
  int? mediaPosition;
  Media({
    this.mediaId,
    this.isMain,
    this.mediaUrlEn,
    this.mediaUrlAr,
    this.mediaUrl,
    this.mediaType,
    this.mediaPosition,
  });

  Media copyWith({
    ValueGetter<int?>? mediaId,
    ValueGetter<bool?>? isMain,
    ValueGetter<String?>? mediaUrlEn,
    ValueGetter<String?>? mediaUrlAr,
    ValueGetter<String?>? mediaUrl,
    ValueGetter<int?>? mediaType,
    ValueGetter<int?>? mediaPosition,
  }) {
    return Media(
      mediaId: mediaId != null ? mediaId() : this.mediaId,
      isMain: isMain != null ? isMain() : this.isMain,
      mediaUrlEn: mediaUrlEn != null ? mediaUrlEn() : this.mediaUrlEn,
      mediaUrlAr: mediaUrlAr != null ? mediaUrlAr() : this.mediaUrlAr,
      mediaUrl: mediaUrl != null ? mediaUrl() : this.mediaUrl,
      mediaType: mediaType != null ? mediaType() : this.mediaType,
      mediaPosition:
          mediaPosition != null ? mediaPosition() : this.mediaPosition,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mediaId': mediaId,
      'isMain': isMain,
      'mediaUrlEn': mediaUrlEn,
      'mediaUrlAr': mediaUrlAr,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'mediaPosition': mediaPosition,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      mediaId: map['mediaId']?.toInt(),
      isMain: map['isMain'],
      mediaUrlEn: map['mediaUrlEn'],
      mediaUrlAr: map['mediaUrlAr'],
      mediaUrl: map['mediaUrl'],
      mediaType: map['mediaType']?.toInt(),
      mediaPosition: map['mediaPosition']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Media(mediaId: $mediaId, isMain: $isMain, mediaUrlEn: $mediaUrlEn, mediaUrlAr: $mediaUrlAr, mediaUrl: $mediaUrl, mediaType: $mediaType, mediaPosition: $mediaPosition)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Media &&
        other.mediaId == mediaId &&
        other.isMain == isMain &&
        other.mediaUrlEn == mediaUrlEn &&
        other.mediaUrlAr == mediaUrlAr &&
        other.mediaUrl == mediaUrl &&
        other.mediaType == mediaType &&
        other.mediaPosition == mediaPosition;
  }

  @override
  int get hashCode {
    return mediaId.hashCode ^
        isMain.hashCode ^
        mediaUrlEn.hashCode ^
        mediaUrlAr.hashCode ^
        mediaUrl.hashCode ^
        mediaType.hashCode ^
        mediaPosition.hashCode;
  }
}