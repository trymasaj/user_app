import 'package:geocoding/geocoding.dart';

class GeoCodedAddress {
  GeoCodedAddress({
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.postalCode,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  });

  final String? name;

  final String? street;

  final String? isoCountryCode;

  final String? country;

  final String? postalCode;

  final String? administrativeArea;

  final String? subAdministrativeArea;

  final String? locality;

  final String? subLocality;

  final String? thoroughfare;

  final String? subThoroughfare;

  factory GeoCodedAddress.fromPlacemark(Placemark placemark) {
    return GeoCodedAddress(
      name: placemark.name,
      street: placemark.street,
      isoCountryCode: placemark.isoCountryCode,
      country: placemark.country,
      postalCode: placemark.postalCode,
      administrativeArea: placemark.administrativeArea,
      subAdministrativeArea: placemark.subAdministrativeArea,
      locality: placemark.locality,
      subLocality: placemark.subLocality,
      thoroughfare: placemark.thoroughfare,
      subThoroughfare: placemark.subThoroughfare,
    );
  }

  String get fullAddress {
    return [
      street,
      subThoroughfare,
      thoroughfare,
      subLocality,
      locality,
      subAdministrativeArea,
      administrativeArea,
      postalCode,
      country
    ].where((element) {
      return element != null && element.isNotEmpty;
    }).join(', ');
  }
}
