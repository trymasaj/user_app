// ignore_for_file: must_be_immutable

part of 'top_up_wallet_payment_method_bloc.dart';

/// Represents the state of TopUpWalletPaymentMethod in the application.
class TopUpWalletPaymentMethodState extends Equatable {
  TopUpWalletPaymentMethodState({this.topUpWalletPaymentMethodModelObj});

  TopUpWalletPaymentMethodModel? topUpWalletPaymentMethodModelObj;

  @override
  List<Object?> get props => [
        topUpWalletPaymentMethodModelObj,
      ];

  TopUpWalletPaymentMethodState copyWith(
      {TopUpWalletPaymentMethodModel? topUpWalletPaymentMethodModelObj}) {
    return TopUpWalletPaymentMethodState(
      topUpWalletPaymentMethodModelObj: topUpWalletPaymentMethodModelObj ??
          this.topUpWalletPaymentMethodModelObj,
    );
  }
}
