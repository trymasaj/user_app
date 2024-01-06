import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/legal/models/legal_model.dart';
import '/core/app_export.dart';
part 'legal_event.dart';
part 'legal_state.dart';

/// A bloc that manages the state of a Legal according to the event that is dispatched to it.
class LegalBloc extends Bloc<LegalEvent, LegalState> {
  LegalBloc(LegalState initialState) : super(initialState) {
    on<LegalInitialEvent>(_onInitialize);
  }

  _onInitialize(
    LegalInitialEvent event,
    Emitter<LegalState> emit,
  ) async {}
}
