// ignore_for_file: must_be_immutable

part of 'top_up_wallet_bloc.dart';

/// Represents the state of TopUpWallet in the application.
class TopUpWalletState extends Equatable {
  TopUpWalletState({this.topUpWalletModelObj});

  TopUpWalletModel? topUpWalletModelObj;

  @override
  List<Object?> get props => [
        topUpWalletModelObj,
      ];
  TopUpWalletState copyWith({TopUpWalletModel? topUpWalletModelObj}) {
    return TopUpWalletState(
      topUpWalletModelObj: topUpWalletModelObj ?? this.topUpWalletModelObj,
    );
  }
}
