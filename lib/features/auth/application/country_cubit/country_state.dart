// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/address/domain/entities/city.dart';
import 'package:masaj/features/address/domain/entities/country.dart';

enum CountryStateStatus {
  initial,
  loading,
  loaded,
  error,
  primaryAddressLoaded,
}

extension HomeStateX on CountryState {
  bool get isInitial => status == CountryStateStatus.initial;

  bool get isLoading => status == CountryStateStatus.loading;

  bool get isLoaded => status == CountryStateStatus.loaded;

  bool get isError => status == CountryStateStatus.error;

  bool get isPrimaryAddressLoaded =>
      status == CountryStateStatus.primaryAddressLoaded;
}

@immutable
class CountryState {
  final CountryStateStatus status;
  final String? message;
  final List<Country>? countries;
  final List<Address>? addresses;
  final Country? currentCountry;
  final Address? currentAddress;
  final List<Area>? areas;

  const CountryState({
    this.status = CountryStateStatus.initial,
    this.message,
    this.countries,
    this.addresses,
    this.currentCountry,
    this.currentAddress,
    this.areas,
  });

  CountryState copyWith({
    CountryStateStatus? status,
    String? message,
    List<Country>? countries,
    List<Area>? areas,
    List<Address>? addresses,
    Country? currentCountry,
    Address? currentAddress,
  }) {
    return CountryState(
      status: status ?? this.status,
      message: message ?? this.message,
      countries: countries ?? this.countries,
      addresses: addresses ?? this.addresses,
      areas: areas ?? this.areas,
      currentCountry: currentCountry ?? this.currentCountry,
      currentAddress: currentAddress ?? this.currentAddress,
    );
  }

  @override
  bool operator ==(covariant CountryState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        listEquals(other.countries, countries) &&
        listEquals(other.addresses, addresses) &&
        other.currentCountry == currentCountry &&
        other.currentAddress == currentAddress &&
        listEquals(other.areas, areas);
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        countries.hashCode ^
        addresses.hashCode ^
        currentCountry.hashCode ^
        currentAddress.hashCode ^
        areas.hashCode;
  }
}
