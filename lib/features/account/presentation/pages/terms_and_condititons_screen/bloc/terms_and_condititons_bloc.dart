import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/account/presentation/pages/terms_and_condititons_screen/models/terms_and_condititons_model.dart';
import '/core/app_export.dart';
part 'terms_and_condititons_event.dart';
part 'terms_and_condititons_state.dart';

/// A bloc that manages the state of a TermsAndCondititons according to the event that is dispatched to it.
class TermsAndCondititonsBloc
    extends Bloc<TermsAndCondititonsEvent, TermsAndCondititonsState> {
  TermsAndCondititonsBloc(TermsAndCondititonsState initialState)
      : super(initialState) {
    on<TermsAndCondititonsInitialEvent>(_onInitialize);
  }

  void _onInitialize(
    TermsAndCondititonsInitialEvent event,
    Emitter<TermsAndCondititonsState> emit,
  ) async {}
}
