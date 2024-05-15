import 'dart:convert';

import 'package:flutter/widgets.dart';

class Address {
  int? id;
  String? nickName;
  int? customerId;
  int? areaId;
  String? addressLineOne;
  double? lat;
  double? lng;
  String? street;
  String? block;
  String? avenue;
  String? floor;
  String? apartment;
  String? additionalDetails;
  bool? isPrimary;
  String? buildingNumber;
  Address({
    this.id,
    this.nickName,
    this.customerId,
    this.areaId,
    this.addressLineOne,
    this.lat,
    this.lng,
    this.street,
    this.block,
    this.avenue,
    this.floor,
    this.apartment,
    this.additionalDetails,
    this.isPrimary,
    this.buildingNumber,
  });
  String get formattedAddress => [street, block, avenue, floor, apartment]
      .where((element) => element!.isNotEmpty)
      .join(', ');

  String get addressTitle => nickName ?? formattedAddress;

  Address copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? nickName,
    ValueGetter<int?>? customerId,
    ValueGetter<int?>? areaId,
    ValueGetter<String?>? addressLineOne,
    ValueGetter<double?>? lat,
    ValueGetter<double?>? lng,
    ValueGetter<String?>? street,
    ValueGetter<String?>? block,
    ValueGetter<String?>? avenue,
    ValueGetter<String?>? floor,
    ValueGetter<String?>? apartment,
    ValueGetter<String?>? additionalDetails,
    ValueGetter<bool?>? isPrimary,
    ValueGetter<String?>? buildingNumber,
  }) {
    return Address(
      id: id != null ? id() : this.id,
      nickName: nickName != null ? nickName() : this.nickName,
      customerId: customerId != null ? customerId() : this.customerId,
      areaId: areaId != null ? areaId() : this.areaId,
      addressLineOne:
          addressLineOne != null ? addressLineOne() : this.addressLineOne,
      lat: lat != null ? lat() : this.lat,
      lng: lng != null ? lng() : this.lng,
      street: street != null ? street() : this.street,
      block: block != null ? block() : this.block,
      avenue: avenue != null ? avenue() : this.avenue,
      floor: floor != null ? floor() : this.floor,
      apartment: apartment != null ? apartment() : this.apartment,
      additionalDetails: additionalDetails != null
          ? additionalDetails()
          : this.additionalDetails,
      isPrimary: isPrimary != null ? isPrimary() : this.isPrimary,
      buildingNumber:
          buildingNumber != null ? buildingNumber() : this.buildingNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickName': nickName,
      'customerId': customerId,
      'areaId': areaId,
      'addressLineOne': addressLineOne,
      'lat': lat,
      'lng': lng,
      'street': street,
      'block': block,
      'avenue': avenue,
      'floor': floor,
      'apartment': apartment,
      'additionalDetails': additionalDetails,
      'isPrimary': isPrimary,
      'buildingNumber': buildingNumber,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id']?.toInt(),
      nickName: map['nickName'],
      customerId: map['customerId']?.toInt(),
      areaId: map['areaId']?.toInt(),
      addressLineOne: map['addressLineOne'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      street: map['street'],
      block: map['block'],
      avenue: map['avenue'],
      floor: map['floor'],
      apartment: map['apartment'],
      additionalDetails: map['additionalDetails'],
      isPrimary: map['isPrimary'],
      buildingNumber: map['buildingNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(id: $id, nickName: $nickName, customerId: $customerId, areaId: $areaId, addressLineOne: $addressLineOne, lat: $lat, lng: $lng, street: $street, block: $block, avenue: $avenue, floor: $floor, apartment: $apartment, additionalDetails: $additionalDetails, isPrimary: $isPrimary, buildingNumber: $buildingNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.id == id &&
        other.nickName == nickName &&
        other.customerId == customerId &&
        other.areaId == areaId &&
        other.addressLineOne == addressLineOne &&
        other.lat == lat &&
        other.lng == lng &&
        other.street == street &&
        other.block == block &&
        other.avenue == avenue &&
        other.floor == floor &&
        other.apartment == apartment &&
        other.additionalDetails == additionalDetails &&
        other.isPrimary == isPrimary &&
        other.buildingNumber == buildingNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nickName.hashCode ^
        customerId.hashCode ^
        areaId.hashCode ^
        addressLineOne.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        street.hashCode ^
        block.hashCode ^
        avenue.hashCode ^
        floor.hashCode ^
        apartment.hashCode ^
        additionalDetails.hashCode ^
        isPrimary.hashCode ^
        buildingNumber.hashCode;
  }
}
