import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/features/account/models/create_new_password_model.dart';
import '/core/app_export.dart';
part 'create_new_password_state.dart';

/// A bloc that manages the state of a CreateNewPasswordOne according to the event that is dispatched to it.
class CreateNewPasswordOneBloc extends BaseCubit<CreateNewPasswordState> {
  CreateNewPasswordOneBloc(CreateNewPasswordState initialState)
      : super(initialState) {}

  void _onInitialize() async {}
}
