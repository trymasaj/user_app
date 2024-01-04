// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'giftcardlist_item_model.dart';

/// This class defines the variables used in the [gift_cards_my_gifts_page],
/// and is typically used to hold data that is passed between different parts of the application.
class GiftCardsMyGiftsModel extends Equatable {
  GiftCardsMyGiftsModel({this.giftcardlistItemList = const []}) {}

  List<GiftcardlistItemModel> giftcardlistItemList;

  GiftCardsMyGiftsModel copyWith(
      {List<GiftcardlistItemModel>? giftcardlistItemList}) {
    return GiftCardsMyGiftsModel(
      giftcardlistItemList: giftcardlistItemList ?? this.giftcardlistItemList,
    );
  }

  @override
  List<Object?> get props => [giftcardlistItemList];
}
