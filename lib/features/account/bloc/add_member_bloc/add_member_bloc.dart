import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/account/models/add_member_model.dart';
import '/core/app_export.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
part 'add_member_event.dart';
part 'add_member_state.dart';

/// A bloc that manages the state of a AddMember according to the event that is dispatched to it.
class AddMemberBloc extends Bloc<AddMemberEvent, AddMemberState> {
  AddMemberBloc(AddMemberState initialState) : super(initialState) {
    on<AddMemberInitialEvent>(_onInitialize);
    on<ChangeCountryEvent>(_changeCountry);
  }

  _changeCountry(
    ChangeCountryEvent event,
    Emitter<AddMemberState> emit,
  ) {
    emit(state.copyWith(selectedCountry: event.value));
  }

  _onInitialize(
    AddMemberInitialEvent event,
    Emitter<AddMemberState> emit,
  ) async {
    emit(state.copyWith(
        nameEditTextController: TextEditingController(),
        phoneNumberController: TextEditingController(),
        maleValueEditTextController: TextEditingController(),
        femaleValueEditTextController: TextEditingController()));
  }
}
