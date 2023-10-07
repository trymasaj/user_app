import 'package:flutter/foundation.dart';
import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/models/coupon_model.dart';
import '../../../data/repositories/account_repository.dart';

part 'coupon_details_state.dart';

class CouponDetailsCubit extends BaseCubit<CouponDetailsState> {
  CouponDetailsCubit(this._accountRepository)
      : super(
            const CouponDetailsState(status: CouponDetailsStateStatus.initial));

  final AccountRepository _accountRepository;

  Future<void> loadCouponDetails(int id, [bool refresh = false]) async {
    try {
      if (!refresh)
        emit(state.copyWith(status: CouponDetailsStateStatus.loading));
      final couponDetails = await _accountRepository.getCouponDetails(id);

      emit(state.copyWith(
          status: CouponDetailsStateStatus.loaded,
          couponDetails: couponDetails));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: CouponDetailsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh(int id) => loadCouponDetails(id, true);

  Future<void> showCouponCode(int id) async {
    try {
      emit(state.copyWith(status: CouponDetailsStateStatus.loaded));

      final couponCode = await _accountRepository.getCouponCode(id);

      emit(state.copyWith(
          status: CouponDetailsStateStatus.showCode, couponCode: couponCode));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: CouponDetailsStateStatus.error, errorMessage: e.toString()));
    }
  }
}
