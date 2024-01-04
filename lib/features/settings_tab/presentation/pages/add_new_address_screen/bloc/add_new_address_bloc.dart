import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/presentation/pages/add_new_address_screen/models/add_new_address_model.dart';
import '/core/app_export.dart';
part 'add_new_address_event.dart';
part 'add_new_address_state.dart';

/// A bloc that manages the state of a AddNewAddress according to the event that is dispatched to it.
class AddNewAddressBloc extends Bloc<AddNewAddressEvent, AddNewAddressState> {
  AddNewAddressBloc(AddNewAddressState initialState) : super(initialState) {
    on<AddNewAddressInitialEvent>(_onInitialize);
    on<ChangeSwitchEvent>(_changeSwitch);
  }

 void _changeSwitch(
    ChangeSwitchEvent event,
    Emitter<AddNewAddressState> emit,
  ) {
    emit(state.copyWith(
      isSelectedSwitch: event.value,
    ));
  }

  void _onInitialize(
    AddNewAddressInitialEvent event,
    Emitter<AddNewAddressState> emit,
  ) async {
    emit(state.copyWith(
      nameEditTextController: TextEditingController(),
      blockEditTextController: TextEditingController(),
      streetEditTextController: TextEditingController(),
      avenueEditTextController: TextEditingController(),
      houseBuildingNoEditTextController: TextEditingController(),
      floorEditTextController: TextEditingController(),
      apartmentNoEditTextController: TextEditingController(),
      additionalDirectionEditTextController: TextEditingController(),
      isSelectedSwitch: false,
    ));
  }
}
