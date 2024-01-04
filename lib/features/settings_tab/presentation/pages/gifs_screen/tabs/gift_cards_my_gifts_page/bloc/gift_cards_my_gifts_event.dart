// ignore_for_file: must_be_immutable

part of 'gift_cards_my_gifts_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///GiftCardsMyGifts widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class GiftCardsMyGiftsEvent extends Equatable {}

/// Event that is dispatched when the GiftCardsMyGifts widget is first created.
class GiftCardsMyGiftsInitialEvent extends GiftCardsMyGiftsEvent {
  @override
  List<Object?> get props => [];
}
