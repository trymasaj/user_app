import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/states/app_state.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
import 'package:masaj/features/address/domain/entities/city.dart';
import 'package:masaj/features/address/domain/entities/country.dart';
import 'package:masaj/features/address/infrastructure/repos/address_repo.dart';
import 'package:masaj/core/app_export.dart';
part 'select_location_state.dart';

class SelectAreaArguments {
  final int countryId, areaId;

  SelectAreaArguments({required this.countryId, required this.areaId});
}

abstract class SelectAreaCubit extends Cubit<SelectAreaState> {

  AbsLogger logger = DI.find();

  static const routeName = '/select-location';
  SelectAreaCubit(
    this._repo,
  ) : super(SelectAreaState.initial());
  final AddressRepo _repo;

  Future<void> init();

  Future<List<Country>> getCountries() async {
    emit(state.copyWith(countries: const DataLoadState.loading()));
    final countries = await _repo.getCountries();
    emit(state.copyWith(countries: DataLoadState.loaded(countries)));
    return countries;
  }

  Future<List<Area>> getAreasFromCountry(Country selectedCountry) async {
    emit(state.copyWith(cities: const DataLoadState.loading()));
    final areas = await _repo.getAreas(selectedCountry.id!);
    emit(state.copyWith(cities: DataLoadState.loaded(areas)));
    return areas;
  }

  Future<void> getAreas() async {
    final selectedCountry = state.selectedCountry.toNullable();
    if (selectedCountry == null) return;
    await getAreasFromCountry(selectedCountry);
  }

  Future<void> onCountryChanged(Country country) async {
    emit(state.copyWith(selectedCountry: some(country)));
    await getAreas();
  }

  void onCityChanged(Area city) {
    emit(state.copyWith(selectedArea: some(city)));
  }

  Future<bool> onContinuePressed() async {
    final selectedCountry = state.selectedCountry.toNullable();
    final selectedCity = state.selectedArea.toNullable();
    if (selectedCountry == null || selectedCity == null) {
      return false;
    }
    await _repo.setCountry(selectedCountry);
    return true;
  }
}


class InitiallySelectAreaCubit extends SelectAreaCubit {
  late SelectAreaArguments arguments;

  InitiallySelectAreaCubit(super.repo);

  void initArgs(SelectAreaArguments args){
    this.arguments = args;
  }

  Future<void> getData() async {
    logger.debug( '[$runtimeType].getData():arguments: ${arguments.countryId} ${arguments.areaId}');
    final result = await getCountries();
    logger.debug('result', result.map((e) => e.id));
    final selectedId =
        result.singleWhere((element) => element.id == arguments.countryId);
    logger.debug('selectedId', selectedId);
    emit(state.copyWith(selectedCountry: some(selectedId)));
    if (result.isEmpty) {
      return;
    }
    final areas = await getAreasFromCountry(result.first);
    emit(state.copyWith(
        selectedArea: some(
            areas.singleWhere((element) => element.id == arguments!.areaId))));
  }

  @override
  Future<void> init() {
    return getData();
  }
}


class NotInitiallySelectAreaCubit extends SelectAreaCubit {
  NotInitiallySelectAreaCubit(super.repo);

  @override
  Future<void> init() {
    return getCountries();
  }
}
