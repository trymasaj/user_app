import 'package:masaj/features/legal/bloc/privacy_policy_bloc/privacy_policy_state.dart';
import 'package:masaj/features/legal/bloc/privacy_policy_bloc/privacy_policy_state.dart';

import '/core/app_export.dart';

/// A bloc that manages the state of a PrivacyPolicy according to the event that is dispatched to it.
class PrivacyPolicyBloc extends Cubit<PrivacyPolicyState> {
  PrivacyPolicyBloc(PrivacyPolicyState initialState) : super(initialState) {}

  void _onInitialize() async {}
}
