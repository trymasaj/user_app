// ignore_for_file: must_be_immutable

part of 'select_location_bloc.dart';

/// Represents the state of SelectLocation in the application.
class SelectLocationState extends Equatable {
  SelectLocationState({
    required this.selectedCountry,
    required this.selectedCity,
    required this.countries,
    required this.cities,
  });

  List<Country> get countriesLoaded =>
      (countries as DataLoadLoadedState<List<Country>>).data;
  List<City> get citiesLoaded =>
      (cities as DataLoadLoadedState<List<City>>).data;
  final DataLoadState<List<Country>> countries;
  final DataLoadState<List<City>> cities;
  final Option<Country> selectedCountry;
  final Option<City> selectedCity;

  @override
  List<Object?> get props => [selectedCountry, selectedCity, countries, cities];

  SelectLocationState copyWith({
    Option<Country>? selectedCountry,
    Option<City>? selectedCity,
    DataLoadState<List<Country>>? countries,
    DataLoadState<List<City>>? cities,
  }) {
    return SelectLocationState(
      cities: cities ?? this.cities,
      countries: countries ?? this.countries,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
    );
  }

  factory SelectLocationState.initial() {
    return SelectLocationState(
      selectedCountry: none(),
      countries: const DataLoadState.initial(),
      cities: const DataLoadState.initial(),
      selectedCity: none(),
    );
  }
}
