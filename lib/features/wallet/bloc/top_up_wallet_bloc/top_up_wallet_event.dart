// ignore_for_file: must_be_immutable

part of 'top_up_wallet_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///TopUpWallet widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class TopUpWalletEvent extends Equatable {}

/// Event that is dispatched when the TopUpWallet widget is first created.
class TopUpWalletInitialEvent extends TopUpWalletEvent {
  @override
  List<Object?> get props => [];
}
