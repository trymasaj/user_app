part of 'map_location_picker_cubit.dart';

class MapLocationPickerState extends Equatable {
  final GeoCodedAddress address;
  final Option<LatLng> latLng;
  final Option<LatLng> selectedLatlng;

  const MapLocationPickerState({
    required this.address,
    required this.latLng,
    required this.selectedLatlng,
  });

  MapLocationPickerState copyWith(
      {GeoCodedAddress? address,
      Option<LatLng>? latLng,
      Option<LatLng>? selectedLatlng}) {
    return MapLocationPickerState(
      selectedLatlng: selectedLatlng ?? this.selectedLatlng,
      latLng: latLng ?? this.latLng,
      address: address ?? this.address,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [address, latLng, selectedLatlng];

  factory MapLocationPickerState.initial() {
    return MapLocationPickerState(
        selectedLatlng: none(), address: GeoCodedAddress(), latLng: none());
  }
}
