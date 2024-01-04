// ignore_for_file: must_be_immutable

part of 'gift_cards_my_gifts_tab_container_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///GiftCardsMyGiftsTabContainer widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class GiftCardsMyGiftsTabContainerEvent extends Equatable {}

/// Event that is dispatched when the GiftCardsMyGiftsTabContainer widget is first created.
class GiftCardsMyGiftsTabContainerInitialEvent
    extends GiftCardsMyGiftsTabContainerEvent {
  @override
  List<Object?> get props => [];
}
