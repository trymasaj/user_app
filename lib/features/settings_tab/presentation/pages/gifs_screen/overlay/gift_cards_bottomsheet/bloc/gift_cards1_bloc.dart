import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/presentation/pages/gifs_screen/overlay/gift_cards_bottomsheet/models/gift_cards1_model.dart';
import '/core/app_export.dart';
part 'gift_cards1_event.dart';
part 'gift_cards1_state.dart';

/// A bloc that manages the state of a GiftCards1 according to the event that is dispatched to it.
class GiftCards1Bloc extends Bloc<GiftCards1Event, GiftCards1State> {
  GiftCards1Bloc(GiftCards1State initialState) : super(initialState) {
    on<GiftCards1InitialEvent>(_onInitialize);
  }

  _onInitialize(
    GiftCards1InitialEvent event,
    Emitter<GiftCards1State> emit,
  ) async {}
}
