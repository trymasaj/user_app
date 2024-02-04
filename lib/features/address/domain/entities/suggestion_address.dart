class SuggestionAddress {
  final String address, placeId;

  SuggestionAddress({required this.address, required this.placeId});

  factory SuggestionAddress.fromMap(Map<String, dynamic> map) {
    return SuggestionAddress(
      address: map['description'] as String,
      placeId: map['place_id'] as String,
    );
  }
}
