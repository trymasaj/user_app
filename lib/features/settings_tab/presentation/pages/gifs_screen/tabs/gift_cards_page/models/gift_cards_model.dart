// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'giftcardsection_item_model.dart';

/// This class defines the variables used in the [gift_cards_page],
/// and is typically used to hold data that is passed between different parts of the application.
class GiftCardsModel extends Equatable {
  GiftCardsModel({this.giftcardsectionItemList = const []}) {}

  List<GiftcardsectionItemModel> giftcardsectionItemList;

  GiftCardsModel copyWith(
      {List<GiftcardsectionItemModel>? giftcardsectionItemList}) {
    return GiftCardsModel(
      giftcardsectionItemList:
          giftcardsectionItemList ?? this.giftcardsectionItemList,
    );
  }

  @override
  List<Object?> get props => [giftcardsectionItemList];
}
