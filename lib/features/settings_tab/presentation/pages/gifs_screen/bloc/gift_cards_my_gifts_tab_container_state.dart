// ignore_for_file: must_be_immutable

part of 'gift_cards_my_gifts_tab_container_bloc.dart';

/// Represents the state of GiftCardsMyGiftsTabContainer in the application.
class GiftCardsMyGiftsTabContainerState extends Equatable {
  GiftCardsMyGiftsTabContainerState(
      {this.giftCardsMyGiftsTabContainerModelObj});

  GiftCardsMyGiftsTabContainerModel? giftCardsMyGiftsTabContainerModelObj;

  @override
  List<Object?> get props => [
        giftCardsMyGiftsTabContainerModelObj,
      ];
  GiftCardsMyGiftsTabContainerState copyWith(
      {GiftCardsMyGiftsTabContainerModel?
          giftCardsMyGiftsTabContainerModelObj}) {
    return GiftCardsMyGiftsTabContainerState(
      giftCardsMyGiftsTabContainerModelObj:
          giftCardsMyGiftsTabContainerModelObj ??
              this.giftCardsMyGiftsTabContainerModelObj,
    );
  }
}
