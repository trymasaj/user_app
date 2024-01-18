import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/features/wallet/domain/entites/package.dart';
import 'package:masaj/features/wallet/value_objects/coupon_code.dart';

abstract class WalletRepository {
  final NetworkService client;

  WalletRepository(this.client);
  Future<void> purchasePackage(Package package);
  Future<void>redeemCouponCode(CouponCode couponCode);
}
