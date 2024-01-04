// ignore_for_file: must_be_immutable

part of 'phone_bloc.dart';

/// Represents the state of Phone in the application.
class PhoneState extends Equatable {
  PhoneState({
    this.phoneNumberController,
    this.selectedCountry,
    this.phoneModelObj,
  });

  TextEditingController? phoneNumberController;

  PhoneModel? phoneModelObj;

  Country? selectedCountry;

  @override
  List<Object?> get props => [
        phoneNumberController,
        selectedCountry,
        phoneModelObj,
      ];
  PhoneState copyWith({
    TextEditingController? phoneNumberController,
    Country? selectedCountry,
    PhoneModel? phoneModelObj,
  }) {
    return PhoneState(
      phoneNumberController:
          phoneNumberController ?? this.phoneNumberController,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      phoneModelObj: phoneModelObj ?? this.phoneModelObj,
    );
  }
}
