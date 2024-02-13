import 'dart:convert';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/data/device/location_helper.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/address/domain/entities/city.dart';
import 'package:masaj/features/address/domain/entities/country.dart';
import 'package:masaj/features/address/domain/entities/geo_coded_address.dart';
import 'package:masaj/features/address/domain/entities/suggestion_address.dart';
import 'package:masaj/features/auth/data/datasources/auth_local_datasource.dart';

@LazySingleton()
class AddressRepo {
  final NetworkService networkService;
  final CacheService cacheService;
  final DeviceLocation deviceLocation;
  final AuthLocalDataSource localDataSource;

  AddressRepo(this.networkService, this.cacheService, this.deviceLocation,
      this.localDataSource);

  final apiKey = 'AIzaSyBi3wkpn58eD7WGMb_24psMehqejdg6wu0';

  Future<LatLng?> getCurrentLocation() async {
    final location = await deviceLocation.getMyLocation();
    if (location == null) return null;
    return LatLng(location.latitude, location.longitude);
  }

  @override
  Future<List<Country>> getCountries() async {
    final response = await networkService.get(ApiEndPoint.GET_COUNTRIES);
    final result = (response.data as List)
        .map((e) => Country.fromMap(e))
        .where((element) => element.isActive ?? false)
        .toList();
    return result;
  }

  Future<List<Area>> getAreas(int countryId) async {
    final response = await networkService.get(
        '${ApiEndPoint.BASE_URL}/Countries/${countryId}/areas',
        headers: {'x-country-id': countryId.toString()});
    final result = (response.data as List).map((e) => Area.fromMap(e)).toList();
    return result;
  }

  Future<GeoCodedAddress> getAddressFromLatLng(LatLng latLng) async {
    final currentLang = await cacheService.getLanguageCode();
    final isArabic = currentLang == 'ar';
    final formattedLang = isArabic ? 'ar_SA' : 'en_US';
    final placeMarks = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: formattedLang);
    final address = placeMarks.first;
    return GeoCodedAddress.fromPlacemark(placeMarks.first);
  }

  Future<LatLng> getLatLongFromPlaceId(String placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey';
    var response = await networkService.get(url);
    final location = (response.data['result']['geometry']['location']);
    return LatLng(location['lat'], location['lng']);
  }

  Future<List<SuggestionAddress>> getSuggestion(String input) async {
    const baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final request = '$baseURL?input=$input&key=$apiKey';
    var response = await networkService.get(request);
    return ((response.data)['predictions'] as List)
        .map((e) => SuggestionAddress.fromMap(e))
        .toList();
  }

  Future<void> setCountry(Country country) async {
    //TODO: check if country code is null throw exception
    if (country.code == null) return;

    await cacheService.setCountryCode(country.code!);
    await cacheService.setCurrentCountry(country);
  }

  Future<Country?> getSavedCountry() async {
    return await cacheService.getCurrentCountry();
  }

  Future<Address?> addAddress(Address address) async {
    final user = await localDataSource.getUserData();

    log(jsonEncode({...address.toMap(), 'customerId': user!.id}));
    print('address to map');
    final result = await networkService.post(ApiEndPoint.ADDRESS,
        data: {...address.toMap(), 'customerId': user!.id});
    return Address.fromMap(result.data);
  }

  Future<Address?> updateAddress(int addressId, Address newAddress) async {
    final user = await localDataSource.getUserData();
    final result = await networkService.put('${ApiEndPoint.ADDRESS}/$addressId',
        data: {...newAddress.toMap(), 'customerId': user!.id});
    return newAddress;
  }

  Future<List<Address>> getAddresses() async {
    final response = await networkService.get(
      ApiEndPoint.ADDRESS,
    );
    final result =
        (response.data as List).map((e) => Address.fromMap(e)).toList();
    return result;
  }
  // delete

  Future<void> deleteAddress(int addressId) async {
    await networkService.delete('${ApiEndPoint.ADDRESS}/$addressId');
  }
}
