// ignore_for_file: must_be_immutable

part of 'wallet_bloc.dart';

enum WalletStateStatus { initial, loading, loaded, error }

extension WalletStateX on WalletState {
  bool get isInitial => status == WalletStateStatus.initial;

  bool get isLoading => status == WalletStateStatus.loading;

  bool get isLoaded => status == WalletStateStatus.loaded;

  bool get isError => status == WalletStateStatus.error;
}

/// Represents the state of Wallet in the application.
class WalletState extends Equatable {
  const WalletState({required this.wallet, required this.status});

  final Option<Wallet> wallet;
  final WalletStateStatus status;

  @override
  List<Object?> get props => [
        wallet,
      ];

  WalletState copyWith({Option<Wallet>? wallet, WalletStateStatus? status}) {
    return WalletState(
      wallet: wallet ?? this.wallet,
      status: status ?? this.status,
    );
  }

  factory WalletState.initial() =>
      WalletState(wallet: none(), status: WalletStateStatus.initial);
}
