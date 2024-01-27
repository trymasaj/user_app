import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum AddressType { home, work, other }

class Address with EquatableMixin {
  final int id;
  final LatLng? latlng;
  final String? nickName, additionalDirection;
  final String country,
      region,
      block,
      street,
      avenue,
      building,
      floor,
      apartment;
  final AddressType type;
  final bool isPrimary;

  Address(
      {required this.nickName,
      required this.additionalDirection,
      this.id = 4,
      this.isPrimary = false,
      required this.country,
      this.latlng,
      required this.type,
      required this.region,
      required this.block,
      required this.street,
      required this.avenue,
      required this.building,
      required this.floor,
      required this.apartment});
  static const nickNameKey = 'nickName';
  static const additionalDirectionKey = 'additional_direction';
  static const countryKey = 'country';
  static const regionKey = 'region';
  static const blockKey = 'block';
  static const streetKey = 'street';
  static const avenueKey = 'avenue';
  static const buildingKey = 'building';
  static const floorKey = 'floor';
  static const apartmentKey = 'apartment';
  static const isPrimaryKey = 'is_primary';
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
      type: AddressType.home,
      nickName: map[nickNameKey],
      additionalDirection: map[additionalDirectionKey],
      country: '',
      region: '',
      block: map[blockKey],
      street: map[streetKey],
      avenue: map[avenueKey],
      building: map[buildingKey],
      floor: map[floorKey],
      apartment: map[apartmentKey],
      isPrimary: map[isPrimaryKey],
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      nickNameKey: nickName,
      additionalDirectionKey: additionalDirection,
      countryKey: country,
      regionKey: region,
      blockKey: block,
      streetKey: street,
      avenueKey: avenue,
      buildingKey: building,
      floorKey: floor,
      apartmentKey: apartment,
      isPrimaryKey: isPrimary,
    };
  }

  Address copyWith({
    String? nickName,
    String? additionalDirection,
    String? country,
    String? region,
    String? block,
    String? street,
    String? avenue,
    String? building,
    String? floor,
    String? apartment,
    AddressType? type,
    bool? isPrimary,
    LatLng? latLng
  }) {
    return Address(
      latlng: latLng ?? this.latlng,
      nickName: nickName ?? this.nickName,
      additionalDirection: additionalDirection ?? this.additionalDirection,
      country: country ?? this.country,
      region: region ?? this.region,
      block: block ?? this.block,
      street: street ?? this.street,
      avenue: avenue ?? this.avenue,
      building: building ?? this.building,
      floor: floor ?? this.floor,
      apartment: apartment ?? this.apartment,
      type: type ?? this.type,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
