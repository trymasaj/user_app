import 'package:equatable/equatable.dart';
import 'package:masaj/features/legal/models/legal_model.dart';
import 'package:masaj/core/app_export.dart';
part 'legal_state.dart';

/// A bloc that manages the state of a Legal according to the event that is dispatched to it.
class LegalBloc extends Cubit<LegalState> {
  LegalBloc(super.initialState);

  _onInitialize() async {}
}
