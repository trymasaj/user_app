import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/features/account/models/my_profile_model.dart';
import '/core/app_export.dart';
part 'my_profile_state.dart';

/// A bloc that manages the state of a MyProfile according to the event that is dispatched to it.
class MyProfileBloc extends BaseCubit<MyProfileState> {
  MyProfileBloc(MyProfileState initialState) : super(initialState) {}

  Future<void> _onInitialize() async {}
}
