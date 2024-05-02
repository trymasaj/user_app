import 'package:masaj/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:masaj/features/wallet/models/wallet_amounts.dart';
import 'package:masaj/features/wallet/models/wallet_model.dart';

abstract class WalletRepository {
  Future<WalletModel> getWalletBalance();
  Future<WalletModel> chargeWallet(
      {required int paymentMethod, required int walletPredefinedWalletId});
  Future<List<WalletAmountsModel>> getPredefinedAmounts();
}

class WalletRepositoryImpl extends WalletRepository {
  WalletRepositoryImpl(this._walletDataSource);

  final WalletDataSource _walletDataSource;

  @override
  Future<WalletModel> chargeWallet(
          {required int paymentMethod,
          required int walletPredefinedWalletId}) =>
      _walletDataSource.chargeWallet(
          paymentMethod: paymentMethod,
          walletPredefinedWalletId: walletPredefinedWalletId);

  @override
  Future<List<WalletAmountsModel>> getPredefinedAmounts() =>
      _walletDataSource.getPredefinedAmounts();

  @override
  Future<WalletModel> getWalletBalance() =>
      _walletDataSource.getWalletBalance();
}
