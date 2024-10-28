// ignore_for_file: void_checks
import 'dart:developer';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/gifts/data/enums/gift_card_status.dart';
import 'package:masaj/features/gifts/data/model/gift_model.dart';
import 'package:masaj/features/gifts/data/model/purchased_gift_card.dart';
import 'package:masaj/features/gifts/data/model/redeem_git_card_model.dart';

abstract class GiftsDataSource {
  Future<List<GiftModel>> getGitsCards();
  Future<List<PurchasedGiftCard>> getPurchasedGitsCards(
      GiftCardStatus giftCardStatus);
  Future<GiftModel> purchaseGiftCard(int paymentMethod);
  Future<RedeemGiftCard> redeemGiftCard(String code);
}

class GiftsDataSourceImpl extends GiftsDataSource {
  final NetworkService _networkService;

  GiftsDataSourceImpl({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<List<GiftModel>> getGitsCards() {
    const url = ApiEndPoint.GET_GIFT_CARDS;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      log(response.data.toString());
      return result != null
          ? (result as List).map((e) => GiftModel.fromMap(e)).toList()
          : [];
    });
  }

  @override
  Future<List<PurchasedGiftCard>> getPurchasedGitsCards(
      GiftCardStatus giftCardStatus) {
    const url = ApiEndPoint.GET_PURCHASED_GIFT_CARDS;
    return _networkService.get(url,
        queryParameters: {'status': giftCardStatus.index}).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      log(response.data.toString());
      return result != null
          ? (result as List).map((e) => PurchasedGiftCard.fromMap(e)).toList()
          : [];
    });
  }

  @override
  Future<GiftModel> purchaseGiftCard(int paymentMethod) {
    const url = ApiEndPoint.BUY_GIFT_CARD;
    var param = {'paymentMethod': paymentMethod};
    return _networkService.post(url, data: param).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      log(response.data.toString());
      return GiftModel.fromMap(result);
    });
  }

  @override
  Future<RedeemGiftCard> redeemGiftCard(String code) {
    const url = ApiEndPoint.REDEEM_GIFT_CARDS;
    var param = {'code': code};
    return _networkService.post(url, data: param).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
      final result = response.data;
      return RedeemGiftCard.fromMap(result);
    });
  }
}
