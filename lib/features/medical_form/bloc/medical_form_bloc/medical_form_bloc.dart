import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/widgets/selection_popup_model.dart';
import 'package:masaj/features/settings_tab/models/medical_form_model.dart';
import '/core/app_export.dart';
part 'medical_form_state.dart';

/// A bloc that manages the state of a MedicalForm according to the event that is dispatched to it.
class MedicalFormBloc extends Cubit<MedicalFormState> {
  MedicalFormBloc(MedicalFormState initialState) : super(initialState) {}

  void _changeDropDown() {
    emit(state.copyWith());
  }

  List<SelectionPopupModel> fillDropdownItemList() {
    return [
      SelectionPopupModel(
        id: 1,
        title: "Item One",
        isSelected: true,
      ),
      SelectionPopupModel(
        id: 2,
        title: "Item Two",
      ),
      SelectionPopupModel(
        id: 3,
        title: "Item Three",
      )
    ];
  }

  void _onInitialize() async {
    emit(state.copyWith(
      editTextController: TextEditingController(),
      editTextController1: TextEditingController(),
      editTextController2: TextEditingController(),
      editTextController3: TextEditingController(),
      editTextController4: TextEditingController(),
    ));
    emit(state.copyWith(
        medicalFormModelObj: state.medicalFormModelObj?.copyWith(
      dropdownItemList: fillDropdownItemList(),
    )));
  }
}
