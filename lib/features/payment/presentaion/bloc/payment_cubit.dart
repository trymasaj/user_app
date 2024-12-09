import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/clients/payment_service.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';
import 'package:masaj/features/payment/data/repo/payment_repo.dart';
import 'package:masaj/features/payment/presentaion/pages/success_payment.dart';
import 'package:masaj/main.dart';

import '../../../../core/presentation/overlay/show_snack_bar.dart';
part 'payment_state.dart';

class PaymentCubit extends BaseCubit<PaymentState> {
  PaymentCubit({
    required PaymentService paymentService,
    required PaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        _paymentService = paymentService,
        super(const PaymentState());

  final PaymentRepository _paymentRepository;
  final PaymentService _paymentService;

  Future<void> getPaymentMethods() async {
    emit(state.copyWith(status: PaymentStateStatus.loading));
    try {
      final methods = await _paymentRepository.getPaymentMethods();
      emit(state.copyWith(
          status: PaymentStateStatus.getMethods, methods: methods));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: PaymentStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> confirmOrder(
    int? paymentMethodId,
    int? bookingId, {
    bool fromWallet = false,
    double? total,
    String? currencyCode,
    String? countryCode,
  }) async {
    if (paymentMethodId == null || bookingId == null) return;
    emit(state.copyWith(status: PaymentStateStatus.loading));
    try {
      await _paymentService.buy(PaymentParam(
        paymentMethodId: paymentMethodId,
        countryCode: countryCode,
        currency: currencyCode,
        price: total,
        params: {
          'paymentMethod': paymentMethodId,
          'walletPayment': fromWallet,
        },
        onSuccess: () {
          navigatorKey.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => SummaryPaymentPage(
                  bookingId: bookingId,
                ),
              ),
              (_) => true);
        },
        onFailure: () {
          navigatorKey.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => SummaryPaymentPage(
                  bookingId: bookingId,
                ),
              ),
              (_) => true);
        },
      ));
      emit(state.copyWith(status: PaymentStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: PaymentStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> tipTherapist(
    BuildContext context,
    int? paymentMethodId, {
    bool fromWallet = false,
    double? total,
    String? currencyCode,
    String? countryCode,
  }) async {
    if (paymentMethodId == null) return;
    emit(state.copyWith(status: PaymentStateStatus.loading));
    try {
      await _paymentService.buy(PaymentParam(
        paymentMethodId: paymentMethodId,
        countryCode: countryCode,
        currency: currencyCode,
        price: total,
        params: {
          "amount": total,
          "paymentMethod": paymentMethodId,
          "walletPayment": fromWallet,
        },
        onSuccess: () {
          navigatorKey.currentState!.pop();
          showSnackBar(context, message: AppText.msg_wallet_success);
        },
        onFailure: () {
          showSnackBar(context, message: AppText.msg_something_went_wrong);
        },
      ));
      emit(state.copyWith(status: PaymentStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: PaymentStateStatus.error, errorMessage: e.toString()));
    }
  }
}