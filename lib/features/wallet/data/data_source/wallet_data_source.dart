import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/enums/request_result_enum.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/wallet/models/wallet_amounts.dart';
import 'package:masaj/features/wallet/models/wallet_model.dart';

abstract class WalletDataSource {
  Future<WalletModel> getWalletBalance();
  Future<WalletModel> chargeWallet(
      {required int paymentMethod, required int walletPredefinedWalletId});
  Future<List<WalletAmountsModel>> getPredefinedAmounts();
}

class WalletDataSourceImpl extends WalletDataSource {
  final NetworkService _networkService;

  WalletDataSourceImpl(this._networkService);

  @override
  Future<WalletModel> chargeWallet(
      {required int paymentMethod, required int walletPredefinedWalletId}) {
    const url = ApiEndPoint.CHARGE_WALLET;
    var param = {
      'paymentMethod': paymentMethod,
      'walletPredefinedAmountId': walletPredefinedWalletId
    };
    return _networkService.post(url, data: param).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(
            message: (response.data['errors'][''] as List).first);
      }
      final result = response.data;
      final resultStatus = result['status'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return WalletModel.fromMap(result);
    });
  }

  @override
  Future<List<WalletAmountsModel>> getPredefinedAmounts() {
    const url = ApiEndPoint.GET_PREDEFINED_WALLET;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(
            message: (response.data['errors'][''] as List).first);
      }
      final result = response.data;

      return (result as List)
          .map((element) => WalletAmountsModel.fromMap(element))
          .toList();
    });
  }

  @override
  Future<WalletModel> getWalletBalance() {
    const url = ApiEndPoint.GET_WALLET_BALANCE;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(
            message: (response.data['errors'][''] as List).first);
      }
      final result = response.data;
      final resultStatus = result['status'];
      if (resultStatus == RequestResult.Failed.name) {
        throw RequestException(message: result['msg']);
      }
      return WalletModel.fromMap(result);
    });
  }
}
