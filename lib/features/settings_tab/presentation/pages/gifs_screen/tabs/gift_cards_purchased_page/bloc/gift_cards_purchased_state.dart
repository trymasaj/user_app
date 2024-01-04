// ignore_for_file: must_be_immutable

part of 'gift_cards_purchased_bloc.dart';

/// Represents the state of GiftCardsPurchased in the application.
class GiftCardsPurchasedState extends Equatable {
  GiftCardsPurchasedState({this.giftCardsPurchasedModelObj});

  GiftCardsPurchasedModel? giftCardsPurchasedModelObj;

  @override
  List<Object?> get props => [
        giftCardsPurchasedModelObj,
      ];
  GiftCardsPurchasedState copyWith(
      {GiftCardsPurchasedModel? giftCardsPurchasedModelObj}) {
    return GiftCardsPurchasedState(
      giftCardsPurchasedModelObj:
          giftCardsPurchasedModelObj ?? this.giftCardsPurchasedModelObj,
    );
  }
}
