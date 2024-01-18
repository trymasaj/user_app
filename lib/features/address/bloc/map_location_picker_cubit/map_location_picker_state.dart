part of 'map_location_picker_cubit.dart';

class MapLocationPickerState extends Equatable {
  final String address;
  final Option<LatLng> latLng;

  const MapLocationPickerState({
    required this.address,
    required this.latLng,
  });

  MapLocationPickerState copyWith({String? address, Option<LatLng>? latLng}) {
    return MapLocationPickerState(
      latLng: latLng ?? this.latLng,
      address: address ?? this.address,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [address,latLng];
  factory MapLocationPickerState.initial() {
    return MapLocationPickerState(address: '', latLng: none());
  }
}
