import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/clients/payment_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/features/wallet/data/repos/wallet_repo_impl.dart';
import 'package:masaj/features/wallet/models/wallet_amounts.dart';
import 'package:masaj/features/wallet/models/wallet_model.dart';
import 'package:masaj/features/wallet/value_objects/coupon_code.dart';
import 'package:masaj/main.dart';
part 'wallet_state.dart';

/// A bloc that manages the state of a TopUpWallet according to the event that is dispatched to it.
class WalletBloc extends BaseCubit<WalletState> {
  final WalletRepository _repository;
  final PaymentService _paymentService;

  WalletBloc(this._repository, this._paymentService)
      : super(const WalletState());

  void onChangedCouponCode(CouponCode code) {
    emit(state.copyWith(couponCode: code));
  }

  void onChooseWallet(bool useWallet) {
    emit(state.copyWith(useWallet: useWallet));
  }

  void onSelectPackageIndex(int index) {
    emit(state.copyWith(selectedPackageIndex: index));
  }

  Future<void> getWalletBalance() async {
    emit(state.copyWith(status: WalletStateStatus.loading));
    try {
      final balance = await _repository.getWalletBalance();
      emit(state.copyWith(
          status: WalletStateStatus.loaded, walletBalance: balance));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: WalletStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> chargeWallet(
    BuildContext context, {
    int? paymentMethodId,
    int? walletPredefinedAmountId,
    double? total,
    String? currencyCode,
    String? countryCode,
  }) async {
    if (paymentMethodId == null || walletPredefinedAmountId == null) return;
    emit(state.copyWith(status: WalletStateStatus.loading));
    try {
      await _paymentService.buy(PaymentParam(
        urlPath: ApiEndPoint.CHARGE_WALLET,
        price: total,
        countryCode: countryCode,
        currency: currencyCode,
        params: {
          'paymentMethod': paymentMethodId,
          'walletPredefinedAmountId': walletPredefinedAmountId,
        },
        paymentMethodId: paymentMethodId,
        onSuccess: () async {
          navigatorKey.currentState!.pop();
          showSnackBar(context, message: AppText.msg_wallet_success);
          //emit(state.copyWith(status: WalletStateStatus.charged));
        },
        onFailure: () {
          navigatorKey.currentState!.pop();
          logger.error('$runtimeType', 'Payment failed');
          emit(state.copyWith(status: WalletStateStatus.error, errorMessage: AppText.msg_something_went_wrong));
          showSnackBar(context, message: AppText.msg_something_went_wrong);
        },
      ));
      //emit(state.copyWith(status: WalletStateStatus.charged));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      logger.error('$runtimeType', e);
      showSnackBar(context, message: AppText.msg_something_went_wrong);
      emit(state.copyWith(
          status: WalletStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getPredefinedAmounts() async {
    emit(state.copyWith(status: WalletStateStatus.loading));
    try {
      final predefinedAmounts = await _repository.getPredefinedAmounts();

      emit(state.copyWith(
          status: WalletStateStatus.loaded,
          predefinedAmounts: predefinedAmounts));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
          status: WalletStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() async {
    getWalletBalance();
  }
}
