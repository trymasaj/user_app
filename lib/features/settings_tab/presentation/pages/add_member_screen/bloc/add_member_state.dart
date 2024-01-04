// ignore_for_file: must_be_immutable

part of 'add_member_bloc.dart';

/// Represents the state of AddMember in the application.
class AddMemberState extends Equatable {
  AddMemberState({
    this.nameEditTextController,
    this.phoneNumberController,
    this.maleValueEditTextController,
    this.femaleValueEditTextController,
    this.selectedCountry,
    this.addMemberModelObj,
  });

  TextEditingController? nameEditTextController;

  TextEditingController? phoneNumberController;

  TextEditingController? maleValueEditTextController;

  TextEditingController? femaleValueEditTextController;

  AddMemberModel? addMemberModelObj;

  Country? selectedCountry;

  @override
  List<Object?> get props => [
        nameEditTextController,
        phoneNumberController,
        maleValueEditTextController,
        femaleValueEditTextController,
        selectedCountry,
        addMemberModelObj,
      ];
  AddMemberState copyWith({
    TextEditingController? nameEditTextController,
    TextEditingController? phoneNumberController,
    TextEditingController? maleValueEditTextController,
    TextEditingController? femaleValueEditTextController,
    Country? selectedCountry,
    AddMemberModel? addMemberModelObj,
  }) {
    return AddMemberState(
      nameEditTextController:
          nameEditTextController ?? this.nameEditTextController,
      phoneNumberController:
          phoneNumberController ?? this.phoneNumberController,
      maleValueEditTextController:
          maleValueEditTextController ?? this.maleValueEditTextController,
      femaleValueEditTextController:
          femaleValueEditTextController ?? this.femaleValueEditTextController,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      addMemberModelObj: addMemberModelObj ?? this.addMemberModelObj,
    );
  }
}
