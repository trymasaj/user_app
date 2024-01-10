import 'package:flutter/material.dart';
import 'package:masaj/core/service/network_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaj/core/entities/decoded_address.dart';
import 'package:masaj/core/service/network_service.dart';

class AddressRepo {
  final NetworkService networkService;

  AddressRepo(this.networkService);
  final apiKey = "AIzaSyBi3wkpn58eD7WGMb_24psMehqejdg6wu0";

  Future<String> getAddressFromLatLng(LatLng latLng) async {
    final placeMarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final address = placeMarks.first;
    print('address is $address');
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
    final baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final request = '$baseURL?input=$input&key=$apiKey';
    var response = await networkService.get(request);
    return ((response.data)['predictions'] as List)
        .map((e) => GeoCodedAddress.fromMap(e))
        .toList();
  }
}
