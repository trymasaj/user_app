part of 'wallet_bloc.dart';

enum WalletStateStatus {
  initial,
  loading,
  loaded,
  charged,
  error,
  deleted,
  added,
  paying
}

extension WalletStateX on WalletState {
  bool get isInitial => status == WalletStateStatus.initial;
  bool get isLoading => status == WalletStateStatus.loading;
  bool get isLoaded => status == WalletStateStatus.loaded;
  bool get isError => status == WalletStateStatus.error;
  bool get isDeleted => status == WalletStateStatus.deleted;
  bool get isAdded => status == WalletStateStatus.added;
  bool get isPaying => status == WalletStateStatus.paying;
  bool get isCharged => status == WalletStateStatus.charged;
}

class WalletState {
  const WalletState({
    this.selectedPackageIndex,
    this.status = WalletStateStatus.initial,
    this.errorMessage,
    this.couponCode,
    this.predefinedAmounts,
    this.wallet,
    this.walletBalance,
    this.useWallet = false,
  });

  final CouponCode? couponCode;
  final int? selectedPackageIndex;
  final WalletStateStatus status;
  final String? errorMessage;
  final List<WalletAmountsModel>? predefinedAmounts;
  final List<WalletTransactionHistory>? wallet;
  final WalletModel? walletBalance;
  final bool useWallet;

  WalletState copyWith({
    CouponCode? couponCode,
    int? selectedPackageIndex,
    String? errorMessage,
    WalletStateStatus? status,
    List<WalletAmountsModel>? predefinedAmounts,
    List<WalletTransactionHistory>? wallet,
    WalletModel? walletBalance,
    bool? useWallet,
  }) {
    return WalletState(
      selectedPackageIndex: selectedPackageIndex ?? this.selectedPackageIndex,
      couponCode: couponCode ?? this.couponCode,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      predefinedAmounts: predefinedAmounts ?? this.predefinedAmounts,
      wallet: wallet ?? this.wallet,
      walletBalance: walletBalance ?? this.walletBalance,
      useWallet: useWallet ?? this.useWallet,
    );
  }
}
