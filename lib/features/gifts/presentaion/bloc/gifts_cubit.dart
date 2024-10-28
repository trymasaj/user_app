import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/clients/payment_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/features/gifts/data/enums/gift_card_status.dart';
import 'package:masaj/features/gifts/data/model/gift_model.dart';
import 'package:masaj/features/gifts/data/model/purchased_gift_card.dart';
import 'package:masaj/features/gifts/data/repo/gifts_repo.dart';

import 'package:masaj/main.dart';

import '../../data/model/redeem_git_card_model.dart';
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

  Future<void> refresh(BuildContext context) async {
    await getGiftCards(context);
  }

  Future<void> getGiftCards(BuildContext context) async {
    emit(state.copyWith(status: GiftsStateStatus.loading));
    try {
      final giftCards = await _giftsRepository.getGitsCards();
      emit(state.copyWith(
          status: GiftsStateStatus.loaded, giftCards: giftCards));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      showSnackBar(context, message: e.toString());
    }
  }

  Future<void> purchaseGiftCard(
    BuildContext context, {
    int? paymentMethodId,
    int? giftId,
    double? total,
    String? currencyCode,
    String? countryCode,
  }) async {
    if (paymentMethodId == null || giftId == null) return;
    emit(state.copyWith(status: GiftsStateStatus.loading));
    try {
      await _paymentService.buy(PaymentParam(
        urlPath: '${ApiEndPoint.BUY_GIFT_CARD}$giftId',
        params: {
          'paymentMethod': paymentMethodId,
        },
        paymentMethodId: paymentMethodId,
        countryCode: countryCode,
        currency: currencyCode,
        price: total,
        onSuccess: () {
          emit(state.copyWith(status: GiftsStateStatus.loaded));
          navigatorKey.currentState!.pop();
          showSnackBar(context,
              message: 'gift card has been redeemed successfully');
        },
        onFailure: () {
          emit(state.copyWith(
              status: GiftsStateStatus.error,
              errorMessage: 'msg_something_went_wrong'));
          navigatorKey.currentState!.pop();
          showSnackBar(context, message: 'Please try again');
        },
      ));
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

  Future<void> redeemGiftCard(BuildContext context, String? code) async {
    if (code == null) return;
    emit(state.copyWith(status: GiftsStateStatus.loading));
    try {
      final redeemGiftCard = await _giftsRepository.redeemGiftCard(code);
      emit(state.copyWith(
          status: GiftsStateStatus.loaded, redeemGiftCard: redeemGiftCard));
    } on RedundantRequestException catch (e) {
      logger.error(e.toString());
    } catch (e) {
      logger.error(e.toString());
      showSnackBar(context, message: e.toString());
    }
  }
}
