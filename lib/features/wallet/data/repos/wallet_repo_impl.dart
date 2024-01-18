import 'package:injectable/injectable.dart';
import 'package:masaj/features/wallet/domain/entites/package.dart';
import 'package:masaj/features/wallet/domain/repos/wallet_repo.dart';
import 'package:masaj/features/wallet/value_objects/coupon_code.dart';

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl extends WalletRepository {
  WalletRepositoryImpl(super.client);

  @override
  Future<void> purchasePackage(Package package) {
    throw UnimplementedError();
  }

  @override
  Future<void> redeemCouponCode(CouponCode couponCode) {
    throw UnimplementedError();
  }
}
