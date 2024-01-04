import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/presentation/pages/gifs_screen/tabs/gift_cards_purchased_page/models/gift_cards_purchased_model.dart';
import '/core/app_export.dart';
part 'gift_cards_purchased_event.dart';
part 'gift_cards_purchased_state.dart';

/// A bloc that manages the state of a GiftCardsPurchased according to the event that is dispatched to it.
class GiftCardsPurchasedBloc
    extends Bloc<GiftCardsPurchasedEvent, GiftCardsPurchasedState> {
  GiftCardsPurchasedBloc(GiftCardsPurchasedState initialState)
      : super(initialState) {
    on<GiftCardsPurchasedInitialEvent>(_onInitialize);
  }

  _onInitialize(
    GiftCardsPurchasedInitialEvent event,
    Emitter<GiftCardsPurchasedState> emit,
  ) async {}
}
