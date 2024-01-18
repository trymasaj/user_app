import 'package:equatable/equatable.dart';
import 'package:masaj/features/legal/models/terms_and_condititons_model.dart';
import 'package:masaj/core/app_export.dart';
part 'terms_and_condititons_state.dart';

/// A bloc that manages the state of a TermsAndCondititons according to the event that is dispatched to it.
class TermsAndCondititonsBloc extends Cubit<TermsAndCondititonsState> {
  TermsAndCondititonsBloc(super.initialState);

  void _onInitialize() async {}
}
