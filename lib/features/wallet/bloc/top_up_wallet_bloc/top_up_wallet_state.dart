// ignore_for_file: must_be_immutable

part of 'top_up_wallet_bloc.dart';

class TopUpWalletState extends Equatable {
  const TopUpWalletState(
      {required this.selectedPackageIndex,
      required this.couponCode,
      required this.packages});

  final CouponCode couponCode;
  final int selectedPackageIndex;
  final DataLoadState<List<Package>> packages;
  List<Package> get loadedPackages =>
      (packages as DataLoadLoadedState<List<Package>>).data;
  Package get selectedPackage => loadedPackages[selectedPackageIndex];
  @override
  List<Object> get props => [couponCode, packages, selectedPackageIndex];
  factory TopUpWalletState.initial() => TopUpWalletState(
      selectedPackageIndex: -1,
      couponCode: CouponCode(''),
      packages: DataLoadState.initial());
  TopUpWalletState copyWith(
      {CouponCode? couponCode,
      DataLoadState<List<Package>>? packages,
      int? selectedPackageIndex}) {
    return TopUpWalletState(
      selectedPackageIndex: selectedPackageIndex ?? this.selectedPackageIndex,
      couponCode: couponCode ?? this.couponCode,
      packages: packages ?? this.packages,
    );
  }
}
