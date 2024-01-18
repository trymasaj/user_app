import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/legal/bloc/privacy_policy_bloc/privacy_policy_state.dart';

/// A bloc that manages the state of a PrivacyPolicy according to the event that is dispatched to it.
class PrivacyPolicyBloc extends Cubit<PrivacyPolicyState> {
  PrivacyPolicyBloc(super.initialState);

  void _onInitialize() async {}
}
