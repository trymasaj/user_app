import 'package:masaj/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:masaj/features/wallet/models/package.dart';
import 'package:masaj/features/wallet/value_objects/coupon_code.dart';

abstract class WalletRepository {
  Future<void> purchasePackage(Package package);
  Future<void> redeemCouponCode(CouponCode couponCode);
}

class WalletRepositoryImpl extends WalletRepository {
  WalletRepositoryImpl(this._walletDataSource);

  final WalletDataSource _walletDataSource;

  @override
  Future<void> purchasePackage(Package package) {
    throw UnimplementedError();
  }

  @override
  Future<void> redeemCouponCode(CouponCode couponCode) {
    throw UnimplementedError();
  }
}
