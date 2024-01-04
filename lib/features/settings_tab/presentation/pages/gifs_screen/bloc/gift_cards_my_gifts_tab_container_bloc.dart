import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/presentation/pages/gifs_screen/models/gift_cards_my_gifts_tab_container_model.dart';
import '/core/app_export.dart';
part 'gift_cards_my_gifts_tab_container_event.dart';
part 'gift_cards_my_gifts_tab_container_state.dart';

/// A bloc that manages the state of a GiftCardsMyGiftsTabContainer according to the event that is dispatched to it.
class GiftCardsMyGiftsTabContainerBloc extends Bloc<
    GiftCardsMyGiftsTabContainerEvent, GiftCardsMyGiftsTabContainerState> {
  GiftCardsMyGiftsTabContainerBloc(
      GiftCardsMyGiftsTabContainerState initialState)
      : super(initialState) {
    on<GiftCardsMyGiftsTabContainerInitialEvent>(_onInitialize);
  }

  _onInitialize(
    GiftCardsMyGiftsTabContainerInitialEvent event,
    Emitter<GiftCardsMyGiftsTabContainerState> emit,
  ) async {}
}
