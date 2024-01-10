import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:masaj/core/entities/decoded_address.dart';
import 'package:masaj/features/address/repos/address_repo.dart';

part 'map_location_picker_state.dart';

class MapLocationPickerCubit extends Cubit<MapLocationPickerState> {
  MapLocationPickerCubit(this._repo) : super(MapLocationPickerState.initial());
  final AddressRepo _repo;
  Future<void> onCameraIdle(LatLng latLng) async {
    print(onCameraIdle);
    final address = await _repo.getAddressFromLatLng(latLng);
    emit(state.copyWith(address: address));
  }

  Future<List<GeoCodedAddress>> onSearch(String search) {
    return _repo.getSuggestion(search);
  }

  Future<void> onSelected(GeoCodedAddress value) async {
    final latlng = await _repo.getLatLongFromPlaceId(value.placeId);
    emit(state.copyWith(latLng: some(latlng)));
  }
}
