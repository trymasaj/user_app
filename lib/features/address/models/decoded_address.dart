class GeoCodedAddress {
  final String address, placeId;

  GeoCodedAddress({required this.address, required this.placeId});

  factory GeoCodedAddress.fromMap(Map<String, dynamic> map) {
    return GeoCodedAddress(
      address: map['description'] as String,
      placeId: map['place_id'] as String,
    );
  }
}
