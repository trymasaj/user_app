import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/clients/payment_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/gifts/data/enums/gift_card_status.dart';
import 'package:masaj/features/gifts/data/model/gift_model.dart';
import 'package:masaj/features/gifts/data/model/purchased_gift_card.dart';
import 'package:masaj/features/gifts/data/repo/gifts_repo.dart';
import 'package:masaj/features/payment/presentaion/pages/success_payment.dart';
import 'package:masaj/main.dart';
part 'gifts_state.dart';

class GiftsCubit extends BaseCubit<GiftsState> {
  GiftsCubit({
    required GiftsRepository giftsRepository,
    required PaymentService paymentService,
  })  : _giftsRepository = giftsRepository,
        _paymentService = paymentService,
        super(const GiftsState());
  final PaymentService _paymentService;
  final GiftsRepository _giftsRepository;

  Future<void> refresh() async {
    await getGiftCards();
  }

  Future<void> getGiftCards() async {
    emit(state.copyWith(status: GiftsStateStatus.loading));
    try {
      final giftCards = await _giftsRepository.getGitsCards();
      emit(state.copyWith(
          status: GiftsStateStatus.loaded, giftCards: giftCards));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: GiftsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> redeemgift({int? paymentMethodId, int? giftId}) async {
    if (paymentMethodId == null || giftId == null) return;
    emit(state.copyWith(status: GiftsStateStatus.loading));
    try {
      await _paymentService.buy(PaymentParam(
        urlPath: '${ApiEndPoint.BUY_GIFT_CARD}$giftId',
        params: {
          'paymentMethod': paymentMethodId,
        },
        paymentMethodId: paymentMethodId,
        onSuccess: () {
          navigatorKey.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => SummaryPaymentPage(
                  bookingId: giftId,
                ),
              ),
              (_) => true);
        },
        onFailure: () {
          navigatorKey.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => SummaryPaymentPage(
                  bookingId: giftId,
                ),
              ),
              (_) => true);
        },
      ));
      emit(state.copyWith(status: GiftsStateStatus.loaded));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: GiftsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> getPurchasedGiftCards(GiftCardStatus giftCardsstatus) async {
    emit(state.copyWith(status: GiftsStateStatus.loading));
    try {
      final giftCards =
          await _giftsRepository.getPurchasedGitsCards(giftCardsstatus);
      emit(state.copyWith(
          status: GiftsStateStatus.loaded, purchasedGiftCards: giftCards));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: GiftsStateStatus.error, errorMessage: e.toString()));
    }
  }
}
