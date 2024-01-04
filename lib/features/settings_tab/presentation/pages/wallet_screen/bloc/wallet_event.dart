// ignore_for_file: must_be_immutable

part of 'wallet_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Wallet widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class WalletEvent extends Equatable {}

/// Event that is dispatched when the Wallet widget is first created.
class WalletInitialEvent extends WalletEvent {
  @override
  List<Object?> get props => [];
}
