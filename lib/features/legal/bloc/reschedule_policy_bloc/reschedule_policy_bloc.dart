import 'package:equatable/equatable.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/legal/models/reschedule_policy_model.dart';

part 'reschedule_policy_state.dart';

/// A bloc that manages the state of a ReschedulePolicy according to the event that is dispatched to it.
class ReschedulePolicyBloc extends Cubit<ReschedulePolicyState> {
  ReschedulePolicyBloc(super.initialState);

  _onInitialize() async {}
}
