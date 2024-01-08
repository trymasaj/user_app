import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/features/legal/models/cancellation_policy_model.dart';
import '/core/app_export.dart';
part 'cancellation_policy_state.dart';

/// A bloc that manages the state of a CancellationPolicy according to the event that is dispatched to it.
class CancellationPolicyBloc extends BaseCubit<CancellationPolicyState> {
  CancellationPolicyBloc(CancellationPolicyState initialState)
      : super(initialState) {}

  void _onInitialize() async {}
}
