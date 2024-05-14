// ignore_for_file: must_be_immutable

part of 'phone_bloc.dart';

/// Represents the state of Phone in the application.
class PhoneState extends Equatable {
  PhoneState({
    this.phoneNumberController,
    this.phoneModelObj,
  });

  TextEditingController? phoneNumberController;

  PhoneModel? phoneModelObj;

  @override
  List<Object?> get props => [
        phoneNumberController,
        phoneModelObj,
      ];

  PhoneState copyWith({
    TextEditingController? phoneNumberController,
    PhoneModel? phoneModelObj,
  }) {
    return PhoneState(
      phoneNumberController:
          phoneNumberController ?? this.phoneNumberController,
      phoneModelObj: phoneModelObj ?? this.phoneModelObj,
    );
  }
}
