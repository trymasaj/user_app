// ignore_for_file: must_be_immutable

part of 'wallet_bloc.dart';

/// Represents the state of Wallet in the application.
class WalletState extends Equatable {
  WalletState({this.walletModelObj});

  WalletModel? walletModelObj;

  @override
  List<Object?> get props => [
        walletModelObj,
      ];
  WalletState copyWith({WalletModel? walletModelObj}) {
    return WalletState(
      walletModelObj: walletModelObj ?? this.walletModelObj,
    );
  }
}
