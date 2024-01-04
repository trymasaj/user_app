// ignore_for_file: must_be_immutable

part of 'gift_cards_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///GiftCards widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class GiftCardsEvent extends Equatable {}

/// Event that is dispatched when the GiftCards widget is first created.
class GiftCardsInitialEvent extends GiftCardsEvent {
  @override
  List<Object?> get props => [];
}
