import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/account/models/phone_model.dart';

part 'phone_state.dart';

/// A bloc that manages the state of a Phone according to the event that is dispatched to it.
class PhoneBloc extends BaseCubit<PhoneState> {
  PhoneBloc(super.initialState);

  Future<void> _onInitialize() async {}
}
