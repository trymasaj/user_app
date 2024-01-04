import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/account/presentation/pages/my_profile_screen/models/my_profile_model.dart';
import '/core/app_export.dart';
part 'my_profile_event.dart';
part 'my_profile_state.dart';

/// A bloc that manages the state of a MyProfile according to the event that is dispatched to it.
class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc(MyProfileState initialState) : super(initialState) {
    on<MyProfileInitialEvent>(_onInitialize);
  }

  Future<void>_onInitialize(
    MyProfileInitialEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(state.copyWith(
      nameFloatingTextFieldController: TextEditingController(),
      emailFloatingTextFieldController: TextEditingController(),
    ));
  }
}
