import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:injectable/injectable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/address/domain/entities/geo_coded_address.dart';
import 'package:masaj/features/address/domain/entities/suggestion_address.dart';
import 'package:masaj/features/address/infrastructure/repos/address_repo.dart';
import 'package:masaj/features/address/presentation/pages/map_location_picker.dart';

part 'map_location_picker_state.dart';

@Injectable()
class MapLocationPickerCubit extends BaseCubit<MapLocationPickerState> {
  MapLocationPickerCubit(this._repo, @factoryParam this.arguments)
      : super(MapLocationPickerState.initial());
  final AddressRepo _repo;
  final MapLocationPickerArguments arguments;

  Future<void> onCameraIdle(LatLng latLng) async {
    print('onCameraIdle $latLng');
    final address = await _repo.getAddressFromLatLng(latLng);
    emit(state.copyWith(address: address, latLng: some(latLng)));
  }

  Future<List<SuggestionAddress>> onSearch(String search) {
    return _repo.getSuggestion(search);
  }

  Future<void> navigateToCurrentLocation() async {
    if (arguments.initialLatlng == null) {
      final latLng = await _repo.getCurrentLocation();
      if (latLng == null) return;
      emit(state.copyWith(selectedLatlng: some(latLng)));
    } else {
      print('args ${arguments.initialLatlng}');
      emit(state.copyWith(selectedLatlng: some(arguments.initialLatlng!)));
    }
  }

  Future<void> onSelected(SuggestionAddress value) async {
    final selected = await _repo.getLatLongFromPlaceId(value.placeId);
    emit(state.copyWith(selectedLatlng: some(selected)));
  }
}
