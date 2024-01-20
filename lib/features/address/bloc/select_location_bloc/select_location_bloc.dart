import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:masaj/core/application/states/app_state.dart';
import 'package:masaj/core/presentation/models/selection_popup_model.dart';
import 'package:masaj/features/address/entities/city.dart';
import 'package:masaj/features/address/entities/country.dart';
import 'package:masaj/features/address/models/select_location_model.dart';
import 'package:masaj/features/address/repos/address_repo.dart';
import '/core/app_export.dart';
part 'select_location_state.dart';

@Injectable()
class SelectLocationBloc extends Cubit<SelectLocationState> {
  SelectLocationBloc(this._repo) : super(SelectLocationState.initial()) {}
  final AddressRepo _repo;

  Future<void> getCountries() async {
    emit(state.copyWith(countries: const DataLoadState.loading()));
    final countries = await _repo.getCountries();
    emit(state.copyWith(countries: DataLoadState.loaded(countries)));
  }

  Future<void> getCities() async {
    final selectedCountry = state.selectedCountry.toNullable();
    if (selectedCountry == null) return;
    emit(state.copyWith(cities: const DataLoadState.loading()));
    final cities = await _repo.getCities(selectedCountry.id!);
    emit(state.copyWith(cities: DataLoadState.loaded(cities)));
  }

  Future<void> onCountryChanged(Country country) async {
    emit(state.copyWith(selectedCountry: some(country)));
    await getCities();
  }

  void onCityChanged(City city) {
    emit(state.copyWith(selectedCity: some(city)));
  }
}
