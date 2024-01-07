import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/address/models/add_new_address_model.dart';
import '/core/app_export.dart';
part 'add_new_address_state.dart';

/// A bloc that manages the state of a AddNewAddress according to the event that is dispatched to it.
class AddNewAddressBloc extends Cubit<AddNewAddressState> {
  AddNewAddressBloc(AddNewAddressState initialState) : super(initialState) {}

  void changeSwitch(bool value) {
    emit(state.copyWith(
      isSelectedSwitch: value,
    ));
  }

  void _onInitialize() async {}
}
