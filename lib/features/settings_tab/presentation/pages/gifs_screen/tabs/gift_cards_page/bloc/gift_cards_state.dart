// ignore_for_file: must_be_immutable

part of 'gift_cards_bloc.dart';

/// Represents the state of GiftCards in the application.
class GiftCardsState extends Equatable {
  GiftCardsState({this.giftCardsModelObj});

  GiftCardsModel? giftCardsModelObj;

  @override
  List<Object?> get props => [
        giftCardsModelObj,
      ];
  GiftCardsState copyWith({GiftCardsModel? giftCardsModelObj}) {
    return GiftCardsState(
      giftCardsModelObj: giftCardsModelObj ?? this.giftCardsModelObj,
    );
  }
}
