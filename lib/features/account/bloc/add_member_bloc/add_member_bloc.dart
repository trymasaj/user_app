import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/core/enums/gender.dart';
import 'package:masaj/features/account/models/add_member_model.dart';
import '/core/app_export.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
part 'add_member_state.dart';

/// A bloc that manages the state of a AddMember according to the event that is dispatched to it.
class AddMemberBloc extends BaseCubit<AddMemberState> {
  AddMemberBloc(super.initialState) {}

  changeCountry(Country country) {
    emit(state.copyWith(selectedCountry: some(country)));
  }

  onInitialize() async {}
}
