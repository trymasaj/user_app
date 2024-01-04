// ignore_for_file: must_be_immutable

part of 'gift_cards_purchased_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///GiftCardsPurchased widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class GiftCardsPurchasedEvent extends Equatable {}

/// Event that is dispatched when the GiftCardsPurchased widget is first created.
class GiftCardsPurchasedInitialEvent extends GiftCardsPurchasedEvent {
  @override
  List<Object?> get props => [];
}
