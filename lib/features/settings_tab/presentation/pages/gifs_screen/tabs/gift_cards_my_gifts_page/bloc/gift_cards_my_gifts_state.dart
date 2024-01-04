// ignore_for_file: must_be_immutable

part of 'gift_cards_my_gifts_bloc.dart';

/// Represents the state of GiftCardsMyGifts in the application.
class GiftCardsMyGiftsState extends Equatable {
  GiftCardsMyGiftsState({this.giftCardsMyGiftsModelObj});

  GiftCardsMyGiftsModel? giftCardsMyGiftsModelObj;

  @override
  List<Object?> get props => [
        giftCardsMyGiftsModelObj,
      ];
  GiftCardsMyGiftsState copyWith(
      {GiftCardsMyGiftsModel? giftCardsMyGiftsModelObj}) {
    return GiftCardsMyGiftsState(
      giftCardsMyGiftsModelObj:
          giftCardsMyGiftsModelObj ?? this.giftCardsMyGiftsModelObj,
    );
  }
}
