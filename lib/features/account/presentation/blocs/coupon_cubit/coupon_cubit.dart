import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/models/coupon_model.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/account/data/models/redeem_coupon_result.dart';
import 'package:masaj/features/account/data/repositories/account_repository.dart';

part 'coupon_state.dart';

class CouponCubit extends BaseCubit<CouponState> {
  CouponCubit(
    this._accountRepository,
  ) : super(const CouponState());

  final AccountRepository _accountRepository;

  Future<void> init() async {
    try {
      emit(state.copyWith(status: CouponStateStatus.loading));
      final allCoupons = await _accountRepository.getAllCoupons();
      final redeemedCoupons = await _accountRepository.getRedeemedCoupons();

      emit(state.copyWith(
        status: CouponStateStatus.loaded,
        allCoupons: allCoupons,
        redeemedCoupons: redeemedCoupons,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CouponStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loadAllCoupons([bool refresh = false]) async {
    try {
      if (!refresh) emit(state.copyWith(status: CouponStateStatus.loading));
      final allCoupons = await _accountRepository.getAllCoupons();

      emit(state.copyWith(
          status: CouponStateStatus.loaded, allCoupons: allCoupons));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CouponStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refreshAllCoupons() => loadAllCoupons(true);

  Future<void> loadRedeemedCoupons([bool refresh = false]) async {
    try {
      if (!refresh) emit(state.copyWith(status: CouponStateStatus.loading));
      final redeemedCoupons = await _accountRepository.getRedeemedCoupons();

      emit(state.copyWith(
          status: CouponStateStatus.loaded, redeemedCoupons: redeemedCoupons));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CouponStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refreshRedeemedCoupons() => loadRedeemedCoupons(true);

  Future<void> loadMoreAllCoupons() async {
    if (state.isLoadingMore) return;
    if (state.allCoupons?.cursor == null) return;
    try {
      emit(state.copyWith(status: CouponStateStatus.loadingMore));

      final allCoupons = await _accountRepository.getAllCoupons(
          cursor: state.allCoupons?.cursor);

      emit(state.copyWith(
          status: CouponStateStatus.loaded,
          allCoupons: allCoupons.copyWith(
              data: [...?state.allCoupons?.data, ...allCoupons.data])));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CouponStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loadMoreRedeemedCoupons() async {
    if (state.isLoadingMore) return;
    if (state.redeemedCoupons?.cursor == null) return;

    try {
      emit(state.copyWith(status: CouponStateStatus.loadingMore));

      final redeemedCoupons = await _accountRepository.getRedeemedCoupons(
          cursor: state.redeemedCoupons?.cursor);

      emit(state.copyWith(
          status: CouponStateStatus.loaded,
          redeemedCoupons: redeemedCoupons.copyWith(data: [
            ...?state.redeemedCoupons?.data,
            ...redeemedCoupons.data
          ])));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CouponStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> redeemCoupon(int id) async {
    try {
      emit(state.copyWith(status: CouponStateStatus.loaded));

      final redeemCouponResult = await _accountRepository.redeemCoupon(id);

      emit(state.copyWith(
          status: CouponStateStatus.redeemSuccess,
          redeemCouponResult: redeemCouponResult));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: CouponStateStatus.error, errorMessage: e.toString()));
    }
  }
}
