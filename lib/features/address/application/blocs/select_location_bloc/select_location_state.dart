// ignore_for_file: must_be_immutable

part of 'select_location_bloc.dart';

/// Represents the state of SelectLocation in the application.
class SelectAreaState extends Equatable {

  const SelectAreaState({
    required this.selectedCountry,
    required this.selectedArea,
    required this.countries,
    required this.cities,
  });

  List<Country> get countriesLoaded =>
      (countries as DataLoadLoadedState<List<Country>>).data;
  List<Area> get citiesLoaded =>
      (cities as DataLoadLoadedState<List<Area>>).data;
  final DataLoadState<List<Country>> countries;
  final DataLoadState<List<Area>> cities;
  final Option<Country> selectedCountry;
  final Option<Area> selectedArea;

  @override
  List<Object?> get props => [selectedCountry, selectedArea, countries, cities];

  SelectAreaState copyWith({
    Option<Country>? selectedCountry,
    Option<Area>? selectedArea,
    DataLoadState<List<Country>>? countries,
    DataLoadState<List<Area>>? cities,
  }) {
    return SelectAreaState(
      cities: cities ?? this.cities,
      countries: countries ?? this.countries,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedArea: selectedArea ?? this.selectedArea,
    );
  }

  factory SelectAreaState.initial() {
    return SelectAreaState(
      selectedCountry: none(),
      countries: const DataLoadState.initial(),
      cities: const DataLoadState.initial(),
      selectedArea: none(),
    );
  }
}
