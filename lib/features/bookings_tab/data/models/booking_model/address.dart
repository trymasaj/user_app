import 'dart:convert';

import 'package:collection/collection.dart';

class Address {
  int? id;
  String? nickName;
  int? customerId;
  int? areaId;
  String? addressLineOne;
  int? lat;
  int? lng;
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

  @override
  String toString() {
    return 'Address(id: $id, nickName: $nickName, customerId: $customerId, areaId: $areaId, addressLineOne: $addressLineOne, lat: $lat, lng: $lng, street: $street, block: $block, avenue: $avenue, floor: $floor, apartment: $apartment, additionalDetails: $additionalDetails, isPrimary: $isPrimary, buildingNumber: $buildingNumber)';
  }

  factory Address.fromMap(Map<String, dynamic> data) => Address(
        id: data['id'] as int?,
        nickName: data['nickName'] as String?,
        customerId: data['customerId'] as int?,
        areaId: data['areaId'] as int?,
        addressLineOne: data['addressLineOne'] as String?,
        lat: data['lat'] as int?,
        lng: data['lng'] as int?,
        street: data['street'] as String?,
        block: data['block'] as String?,
        avenue: data['avenue'] as String?,
        floor: data['floor'] as String?,
        apartment: data['apartment'] as String?,
        additionalDetails: data['additionalDetails'] as String?,
        isPrimary: data['isPrimary'] as bool?,
        buildingNumber: data['buildingNumber'] as String?,
      );

  Map<String, dynamic> toMap() => {
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

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Address].
  factory Address.fromJson(String data) {
    return Address.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Address] to a JSON string.
  String toJson() => json.encode(toMap());

  Address copyWith({
    int? id,
    String? nickName,
    int? customerId,
    int? areaId,
    String? addressLineOne,
    int? lat,
    int? lng,
    String? street,
    String? block,
    String? avenue,
    String? floor,
    String? apartment,
    String? additionalDetails,
    bool? isPrimary,
    String? buildingNumber,
  }) {
    return Address(
      id: id ?? this.id,
      nickName: nickName ?? this.nickName,
      customerId: customerId ?? this.customerId,
      areaId: areaId ?? this.areaId,
      addressLineOne: addressLineOne ?? this.addressLineOne,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      street: street ?? this.street,
      block: block ?? this.block,
      avenue: avenue ?? this.avenue,
      floor: floor ?? this.floor,
      apartment: apartment ?? this.apartment,
      additionalDetails: additionalDetails ?? this.additionalDetails,
      isPrimary: isPrimary ?? this.isPrimary,
      buildingNumber: buildingNumber ?? this.buildingNumber,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Address) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
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
