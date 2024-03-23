import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';
import 'package:masaj/features/payment/data/repo/payment_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends BaseCubit<PaymentState> {
  PaymentCubit({
    required PaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        super(const PaymentState());

  final PaymentRepository _paymentRepository;

  Future<void> getPaymentMethods() async {
    emit(state.copyWith(status: PaymentStateStatus.loading));
    try {
      final methods = await _paymentRepository.getPaymentMethods();
      emit(state.copyWith(status: PaymentStateStatus.loaded, methods: methods));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: PaymentStateStatus.error, errorMessage: e.toString()));
    }
  }
}
