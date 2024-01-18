// ignore_for_file: must_be_immutable

part of 'add_member_bloc.dart';

/// Represents the state of AddMember in the application.
class AddMemberState extends Equatable {
  const AddMemberState({
    required this.name,
    required this.phone,
    required this.gender,
    required this.selectedCountry,
  });

  final String name;
  final String phone;
  final Gender gender;
  final Option<Country> selectedCountry;

  @override
  List<Object?> get props => [
        name,
        gender,
        phone,
        selectedCountry,
      ];

  AddMemberState copyWith({
    String? nameEditTextController,
    String? phoneNumberController,
    Option<Country>? selectedCountry,
    Gender? gender,
    AddMemberModel? addMemberModelObj,
  }) {
    return AddMemberState(
      gender: gender ?? this.gender,
      name: nameEditTextController ?? name,
      phone: phoneNumberController ?? phone,
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }

  factory AddMemberState.initial() => AddMemberState(
      name: '', phone: '', gender: Gender.male, selectedCountry: none());
}
