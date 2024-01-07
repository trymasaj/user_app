import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/legal/models/reschedule_policy_model.dart';
import '/core/app_export.dart';
part 'reschedule_policy_state.dart';

/// A bloc that manages the state of a ReschedulePolicy according to the event that is dispatched to it.
class ReschedulePolicyBloc extends Cubit<ReschedulePolicyState> {
  ReschedulePolicyBloc(ReschedulePolicyState initialState)
      : super(initialState) {}

  _onInitialize() async {}
}
