import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/application/states/app_state.dart';
import 'package:masaj/features/wallet/domain/entites/package.dart';
import 'package:masaj/features/wallet/domain/repos/wallet_repo.dart';
import 'package:masaj/features/wallet/value_objects/coupon_code.dart';

part 'top_up_wallet_state.dart';

/// A bloc that manages the state of a TopUpWallet according to the event that is dispatched to it.
class TopUpWalletBloc extends BaseCubit<TopUpWalletState> {
  final WalletRepository _repository;

  TopUpWalletBloc(this._repository) : super(TopUpWalletState.initial());

  void onChangedCouponCode(CouponCode code) {
    emit(state.copyWith(couponCode: code));
  }

  void onSelectPackageIndex(int index) {
    emit(state.copyWith(selectedPackageIndex: index));
  }

  Future<void> purchasePackage() async {
    await _repository.purchasePackage(state.selectedPackage);
  }

  void redeemCoupon() {
    _repository.redeemCouponCode(state.couponCode);
  }
}
