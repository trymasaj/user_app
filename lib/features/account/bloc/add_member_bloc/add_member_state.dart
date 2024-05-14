// ignore_for_file: must_be_immutable

part of 'add_member_bloc.dart';

/// Represents the state of AddMember in the application.
class AddMemberState extends Equatable {
  const AddMemberState({
    required this.name,
    required this.phone,
    required this.gender,
  });

  final String name;
  final String phone;
  final Gender gender;

  @override
  List<Object?> get props => [
        name,
        gender,
        phone,
      ];

  AddMemberState copyWith({
    String? nameEditTextController,
    String? phoneNumberController,
    Gender? gender,
    AddMemberModel? addMemberModelObj,
  }) {
    return AddMemberState(
      gender: gender ?? this.gender,
      name: nameEditTextController ?? name,
      phone: phoneNumberController ?? phone,
    );
  }

  factory AddMemberState.initial() => AddMemberState(
        name: '',
        phone: '',
        gender: Gender.male,
      );
}
