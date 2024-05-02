import 'package:masaj/features/gifts/data/datasource/gifts_datasource.dart';
import 'package:masaj/features/gifts/data/model/gift_model.dart';
import 'package:masaj/features/gifts/data/model/purchased_gift_card.dart';
import 'package:masaj/features/gifts/data/model/redeem_git_card_model.dart';

abstract class GiftsRepository {
  Future<List<GiftModel>> getGitsCards();
  Future<List<PurchasedGiftCard>> getPurchasedGitsCards();
  Future<GiftModel> purchaseGiftCard(int paymentMethod);
  Future<RedeemGiftCard> redeemGiftCard(String code);
}

class GiftsRepositoryImp extends GiftsRepository {
  final GiftsDataSource _giftsDataSource;

  GiftsRepositoryImp({required GiftsDataSource giftsDataSource})
      : _giftsDataSource = giftsDataSource;
  @override
  Future<List<GiftModel>> getGitsCards() => _giftsDataSource.getGitsCards();

  @override
  Future<List<PurchasedGiftCard>> getPurchasedGitsCards() =>
      _giftsDataSource.getPurchasedGitsCards();

  @override
  Future<GiftModel> purchaseGiftCard(int paymentMethod) =>
      _giftsDataSource.purchaseGiftCard(paymentMethod);
  @override
  Future<RedeemGiftCard> redeemGiftCard(String code) =>
      _giftsDataSource.redeemGiftCard(code);
}
