import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/presentation/pages/gifs_screen/tabs/gift_cards_page/models/gift_cards_model.dart';
import '/core/app_export.dart';
import '../models/giftcardsection_item_model.dart';
part 'gift_cards_event.dart';
part 'gift_cards_state.dart';

/// A bloc that manages the state of a GiftCards according to the event that is dispatched to it.
class GiftCardsBloc extends Bloc<GiftCardsEvent, GiftCardsState> {
  GiftCardsBloc(GiftCardsState initialState) : super(initialState) {
    on<GiftCardsInitialEvent>(_onInitialize);
  }

  _onInitialize(
    GiftCardsInitialEvent event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(state.copyWith(
        giftCardsModelObj: state.giftCardsModelObj?.copyWith(
            giftcardsectionItemList: fillGiftcardsectionItemList())));
  }

  List<GiftcardsectionItemModel> fillGiftcardsectionItemList() {
    return [
      GiftcardsectionItemModel(
          text: "GIFT CARD",
          imageClass: ImageConstant.imgEffects,
          text1: "10",
          text2: "KWD")
    ];
  }
}
