// ignore_for_file: must_be_immutable

part of 'gift_cards1_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///GiftCards1 widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class GiftCards1Event extends Equatable {}

/// Event that is dispatched when the GiftCards1 widget is first created.
class GiftCards1InitialEvent extends GiftCards1Event {
  @override
  List<Object?> get props => [];
}
