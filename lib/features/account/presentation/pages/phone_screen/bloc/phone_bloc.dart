import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/account/presentation/pages/phone_screen/models/phone_model.dart';
import '/core/app_export.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
part 'phone_event.dart';
part 'phone_state.dart';

/// A bloc that manages the state of a Phone according to the event that is dispatched to it.
class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc(PhoneState initialState) : super(initialState) {
    on<PhoneInitialEvent>(_onInitialize);
    on<ChangeCountryEvent>(_changeCountry);
  }

  Future<void> _changeCountry(
    ChangeCountryEvent event,
    Emitter<PhoneState> emit,
  ) async {
    emit(state.copyWith(selectedCountry: event.value));
  }

  Future<void> _onInitialize(
    PhoneInitialEvent event,
    Emitter<PhoneState> emit,
  ) async {
    emit(state.copyWith(phoneNumberController: TextEditingController()));
  }
}
