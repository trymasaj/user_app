import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/presentation/pages/reschedule_policy_screen/models/reschedule_policy_model.dart';
import '/core/app_export.dart';
part 'reschedule_policy_event.dart';
part 'reschedule_policy_state.dart';

/// A bloc that manages the state of a ReschedulePolicy according to the event that is dispatched to it.
class ReschedulePolicyBloc
    extends Bloc<ReschedulePolicyEvent, ReschedulePolicyState> {
  ReschedulePolicyBloc(ReschedulePolicyState initialState)
      : super(initialState) {
    on<ReschedulePolicyInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ReschedulePolicyInitialEvent event,
    Emitter<ReschedulePolicyState> emit,
  ) async {}
}
