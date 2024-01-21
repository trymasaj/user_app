import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/features/address/entities/city.dart';
import 'package:masaj/features/address/entities/country.dart';
import 'package:masaj/features/address/models/decoded_address.dart';

@LazySingleton()
class AddressRepo {
  final NetworkService networkService;
  final CacheService cacheService;

  AddressRepo(this.networkService, this.cacheService);

  final apiKey = 'AIzaSyBi3wkpn58eD7WGMb_24psMehqejdg6wu0';

  @override
  Future<List<Country>> getCountries() async {
    final response = await networkService.get(ApiEndPoint.GET_COUNTRIES);
    final result =
        (response.data as List).map((e) => Country.fromMap(e)).toList();
    return result;
  }

  Future<List<City>> getCities(int countryId) async {
    print('countryId $countryId');
    final response = await networkService.get(ApiEndPoint.GET_CITIES,
        headers: {'x-country-id': countryId.toString()});
    print('response ${response.data}');

    final result = (response.data as List).map((e) => City.fromMap(e)).toList();
    print('result ${result.length}');
    return result;
  }

  Future<String> getAddressFromLatLng(LatLng latLng) async {
    final placeMarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final address = placeMarks.first;
    print('address.thoroughfare is ${address.thoroughfare == null}');
    print('address.administrativeArea is ${address.administrativeArea}');
    return '${address.country} - ${address.thoroughfare} -${address.administrativeArea} - ${address.subAdministrativeArea} - ${address.street} - ${address.name}';
  }

  Future<LatLng> getLatLongFromPlaceId(String placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey';
    var response = await networkService.get(url);
    final location = (response.data['result']['geometry']['location']);
    return LatLng(location['lat'], location['lng']);
  }

  Future<List<GeoCodedAddress>> getSuggestion(String input) async {
    const baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final request = '$baseURL?input=$input&key=$apiKey';
    var response = await networkService.get(request);
    return ((response.data)['predictions'] as List)
        .map((e) => GeoCodedAddress.fromMap(e))
        .toList();
  }

  Future<void> setCountry(Country country) async {
    //TODO: check if country code is null throw exception
    if (country.code == null) return;

    await cacheService.setCountryCode(country.code!);
    await cacheService.setCounterey(country);
  }

  Future<Country?> getSavedCountry() async {
    return await cacheService.getCountry();
  }
}
