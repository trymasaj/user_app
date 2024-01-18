import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/account/models/my_profile_model.dart';

part 'my_profile_state.dart';

/// A bloc that manages the state of a MyProfile according to the event that is dispatched to it.
class MyProfileBloc extends BaseCubit<MyProfileState> {
  MyProfileBloc(super.initialState);

  Future<void> _onInitialize() async {}
}
