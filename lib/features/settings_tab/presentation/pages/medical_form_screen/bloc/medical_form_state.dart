// ignore_for_file: must_be_immutable

part of 'medical_form_bloc.dart';

/// Represents the state of MedicalForm in the application.
class MedicalFormState extends Equatable {
  MedicalFormState({
    this.editTextController,
    this.editTextController1,
    this.editTextController2,
    this.editTextController3,
    this.editTextController4,
    this.selectedDropDownValue,
    this.medicalFormModelObj,
  });

  TextEditingController? editTextController;

  TextEditingController? editTextController1;

  TextEditingController? editTextController2;

  TextEditingController? editTextController3;

  TextEditingController? editTextController4;

  SelectionPopupModel? selectedDropDownValue;

  MedicalFormModel? medicalFormModelObj;

  @override
  List<Object?> get props => [
        editTextController,
        editTextController1,
        editTextController2,
        editTextController3,
        editTextController4,
        selectedDropDownValue,
        medicalFormModelObj,
      ];
  MedicalFormState copyWith({
    TextEditingController? editTextController,
    TextEditingController? editTextController1,
    TextEditingController? editTextController2,
    TextEditingController? editTextController3,
    TextEditingController? editTextController4,
    SelectionPopupModel? selectedDropDownValue,
    MedicalFormModel? medicalFormModelObj,
  }) {
    return MedicalFormState(
      editTextController: editTextController ?? this.editTextController,
      editTextController1: editTextController1 ?? this.editTextController1,
      editTextController2: editTextController2 ?? this.editTextController2,
      editTextController3: editTextController3 ?? this.editTextController3,
      editTextController4: editTextController4 ?? this.editTextController4,
      selectedDropDownValue:
          selectedDropDownValue ?? this.selectedDropDownValue,
      medicalFormModelObj: medicalFormModelObj ?? this.medicalFormModelObj,
    );
  }
}
