import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/account/models/create_new_password_model.dart';
import '/core/app_export.dart';
part 'create_new_password_event.dart';
part 'create_new_password_state.dart';

/// A bloc that manages the state of a CreateNewPasswordOne according to the event that is dispatched to it.
class CreateNewPasswordOneBloc
    extends Bloc<CreateNewPasswordOneEvent, CreateNewPasswordOneState> {
  CreateNewPasswordOneBloc(CreateNewPasswordOneState initialState)
      : super(initialState) {
    on<CreateNewPasswordOneInitialEvent>(_onInitialize);
    on<ChangePasswordVisibilityEvent>(_changePasswordVisibility);
    on<ChangePasswordVisibilityEvent1>(_changePasswordVisibility1);
    on<ChangePasswordVisibilityEvent2>(_changePasswordVisibility2);
  }

  void _changePasswordVisibility(
    ChangePasswordVisibilityEvent event,
    Emitter<CreateNewPasswordOneState> emit,
  ) {
    emit(state.copyWith(
      isShowPassword: event.value,
    ));
  }

  void _changePasswordVisibility1(
    ChangePasswordVisibilityEvent1 event,
    Emitter<CreateNewPasswordOneState> emit,
  ) {
    emit(state.copyWith(
      isShowPassword1: event.value,
    ));
  }

  void _changePasswordVisibility2(
    ChangePasswordVisibilityEvent2 event,
    Emitter<CreateNewPasswordOneState> emit,
  ) {
    emit(state.copyWith(
      isShowPassword2: event.value,
    ));
  }

  void _onInitialize(
    CreateNewPasswordOneInitialEvent event,
    Emitter<CreateNewPasswordOneState> emit,
  ) async {
    emit(state.copyWith(
      passwordEditTextController: TextEditingController(),
      newPasswordEditTextController: TextEditingController(),
      newPasswordEditTextController1: TextEditingController(),
      isShowPassword: true,
      isShowPassword1: true,
      isShowPassword2: true,
    ));
  }
}
