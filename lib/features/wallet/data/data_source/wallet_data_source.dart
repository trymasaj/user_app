import 'package:masaj/core/data/clients/network_service.dart';

abstract class WalletDataSource {}

class WalletDataSourceImpl extends WalletDataSource {
  final NetworkService _networkService;

  WalletDataSourceImpl(this._networkService);
}
