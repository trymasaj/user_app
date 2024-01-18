import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/legal/models/cancellation_policy_model.dart';

part 'cancellation_policy_state.dart';

/// A bloc that manages the state of a CancellationPolicy according to the event that is dispatched to it.
class CancellationPolicyBloc extends BaseCubit<CancellationPolicyState> {
  CancellationPolicyBloc(super.initialState);

  void _onInitialize() async {}
}
