// ignore_for_file: must_be_immutable

part of 'top_up_wallet_payment_method_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///TopUpWalletPaymentMethod widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class TopUpWalletPaymentMethodEvent extends Equatable {}

/// Event that is dispatched when the TopUpWalletPaymentMethod widget is first created.
class TopUpWalletPaymentMethodInitialEvent
    extends TopUpWalletPaymentMethodEvent {
  @override
  List<Object?> get props => [];
}
