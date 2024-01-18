import 'package:flutter_wallet/flutter_wallet.dart';
import 'package:masaj/core/domain/exceptions/add_to_apple_wallet_exception.dart';

abstract class AddToAppleWalletService {
  Future<void> addToWallet(List<int> pass);
}

class AddToAppleWalletServiceImpl implements AddToAppleWalletService {
  @override
  Future<void> addToWallet(List<int> pass) async {
    final success = await FlutterWallet.addPass(pkpass: pass);
    if (success != true) throw AddToAppleWalletException();
  }
}
