import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/features/account/models/phone_model.dart';
import '/core/app_export.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
part 'phone_state.dart';

/// A bloc that manages the state of a Phone according to the event that is dispatched to it.
class PhoneBloc extends BaseCubit<PhoneState> {
  PhoneBloc(PhoneState initialState) : super(initialState) {}

  Future<void> changeCountry(
    Country country,
  ) async {
    emit(state.copyWith(selectedCountry: country));
  }

  Future<void> _onInitialize() async {}
}
