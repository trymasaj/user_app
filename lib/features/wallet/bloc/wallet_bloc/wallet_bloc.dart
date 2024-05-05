import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/clients/payment_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/payment/presentaion/pages/success_payment.dart';
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
      {int? paymentMethodId, int? walletPredefinedAmountId}) async {
    if (paymentMethodId == null || walletPredefinedAmountId == null) return;
    emit(state.copyWith(status: WalletStateStatus.loading));
    try {
      await _paymentService.buy(PaymentParam(
        urlPath: ApiEndPoint.CHARGE_WALLET,
        params: {
          'paymentMethod': paymentMethodId,
          'walletPredefinedAmountId': walletPredefinedAmountId,
        },
        paymentMethodId: paymentMethodId,
        onSuccess: () {
          navigatorKey.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => SummaryPaymentPage(
                  bookingId: walletPredefinedAmountId,
                ),
              ),
              (_) => true);
        },
        onFailure: () {
          navigatorKey.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => SummaryPaymentPage(
                  bookingId: walletPredefinedAmountId,
                ),
              ),
              (_) => true);
        },
      ));
      emit(state.copyWith(status: WalletStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
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

  Future<void> getTransactionHistory() async {
    emit(state.copyWith(status: WalletStateStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
        status: WalletStateStatus.loaded, wallet: fillTransactions()));
  }

  List<WalletTransactionHistory> fillTransactions() {
    return [
      WalletTransactionHistory(
        balance: 12,
        credit: 400,
        transactionReason: 'Booking',
        transactionDate: '12 march 2023 - 2:00 pm',
      ),
      WalletTransactionHistory(
        balance: 12,
        credit: 400,
        transactionReason: 'Booking',
        transactionDate: '12 march 2023 - 2:00 pm',
      ),
      WalletTransactionHistory(
        balance: 12,
        credit: 400,
        transactionReason: 'Booking',
        transactionDate: '12 march 2023 - 2:00 pm',
      )
    ];
  }
}
