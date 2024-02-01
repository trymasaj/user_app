import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum AddressType { home, work, other }

class Address with EquatableMixin {
  final LatLng? latlng;
  final String? nickName, additionalDetails, googleMapAddress;
  final int id, areaId, countryId;
  final String block, street, avenue, building, floor, apartment;
  final bool isPrimary;

  String get addressTitle => nickName ?? googleMapAddress ?? street;

  Address(
      {required this.nickName,
      required this.additionalDetails,
      required this.areaId,
      required this.countryId,
      required this.id,
      this.isPrimary = false,
      this.latlng,
      required this.googleMapAddress,
      required this.block,
      required this.street,
      required this.avenue,
      required this.building,
      required this.floor,
      required this.apartment});

  static const nickNameKey = 'nickName';
  static const idKey = 'id';
  static const additionalDetailsKey = 'additionalDetails';
  static const countryKey = 'countryId';
  static const regionKey = 'region';
  static const blockKey = 'block';
  static const streetKey = 'street';
  static const avenueKey = 'avenue';
  static const buildingKey = 'buildingNumber';
  static const floorKey = 'floor';
  static const apartmentKey = 'apartment';
  static const isPrimaryKey = 'isPrimary';
  static const latKey = 'lat';
  static const longKey = 'lng';
  static const googleMapAddressKey = 'addressLineOne';
  static const areaIdKey = 'areaId';

  String get formattedAddress => [
        street,
        block,
        avenue,
        building,
        floor,
        apartment
      ].where((element) => element.isNotEmpty).join(', ');

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      countryId: map[countryKey],
      id: map[idKey] ?? 0,
      googleMapAddress: map[googleMapAddressKey],
      nickName: map[nickNameKey],
      additionalDetails: map[additionalDetailsKey],
      block: map[blockKey],
      street: map[streetKey],
      avenue: map[avenueKey],
      building: map[buildingKey],
      floor: map[floorKey],
      apartment: map[apartmentKey],
      isPrimary: map[isPrimaryKey],
      areaId: map[areaIdKey],
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      nickNameKey: nickName,
      additionalDetailsKey: additionalDetails,
      blockKey: block,
      streetKey: street,
      avenueKey: avenue,
      buildingKey: building,
      floorKey: floor,
      apartmentKey: apartment,
      latKey: latlng?.latitude,
      longKey: latlng?.longitude,
      isPrimaryKey: isPrimary,
      areaIdKey: areaId,
      countryKey: countryId,
      googleMapAddressKey: googleMapAddress,
    }..removeWhere((key, value) => value == null);
  }

  Address copyWith(
      {String? nickName,
      String? additionalDirection,
      String? block,
      String? street,
      String? avenue,
      String? building,
      String? floor,
      String? apartment,
      String? type,
      bool? isPrimary,
      int? areaId,
      int? countryId,
      LatLng? latLng}) {
    return Address(
      countryId: countryId ?? this.countryId,
      areaId: areaId ?? this.areaId,
      id: id,
      latlng: latLng ?? this.latlng,
      nickName: nickName ?? this.nickName,
      additionalDetails: additionalDirection ?? this.additionalDetails,
      block: block ?? this.block,
      street: street ?? this.street,
      avenue: avenue ?? this.avenue,
      building: building ?? this.building,
      floor: floor ?? this.floor,
      apartment: apartment ?? this.apartment,
      googleMapAddress: type ?? this.googleMapAddress,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  @override
  List<Object?> get props => [
        latlng,
        nickName,
        id,
        block,
        areaId,
        countryId,
        googleMapAddress,
        street,
        avenue,
        building,
        floor,
        apartment,
        additionalDetails,
        isPrimary,
      ];
}
