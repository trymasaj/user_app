import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/presentation/pages/gifs_screen/tabs/gift_cards_my_gifts_page/models/gift_cards_my_gifts_model.dart';
import '/core/app_export.dart';
import '../models/giftcardlist_item_model.dart';
part 'gift_cards_my_gifts_event.dart';
part 'gift_cards_my_gifts_state.dart';

/// A bloc that manages the state of a GiftCardsMyGifts according to the event that is dispatched to it.
class GiftCardsMyGiftsBloc
    extends Bloc<GiftCardsMyGiftsEvent, GiftCardsMyGiftsState> {
  GiftCardsMyGiftsBloc(GiftCardsMyGiftsState initialState)
      : super(initialState) {
    on<GiftCardsMyGiftsInitialEvent>(_onInitialize);
  }

  _onInitialize(
    GiftCardsMyGiftsInitialEvent event,
    Emitter<GiftCardsMyGiftsState> emit,
  ) async {
    emit(state.copyWith(
        giftCardsMyGiftsModelObj: state.giftCardsMyGiftsModelObj?.copyWith(
      giftcardlistItemList: fillGiftcardlistItemList(),
    )));
  }

  List<GiftcardlistItemModel> fillGiftcardlistItemList() {
    return [
      GiftcardlistItemModel(
          imageClass: ImageConstant.imgGroup1000003355,
          text1: "Gift 10 OFF",
          text2: "10 KWD"),
      GiftcardlistItemModel(
          imageClass: ImageConstant.imgGroup1000003355,
          text1: "Gift 25 OFF",
          text2: "25 KWD"),
      GiftcardlistItemModel(
          imageClass: ImageConstant.imgThumbsUpOnprimarycontainer,
          text1: "Gift 100 OFF",
          text2: "100 KWD")
    ];
  }
}
