import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';

abstract class PaymentDataSource {
  Future<List<PaymentMethodModel>> getPaymentMethods();
  Future<void> purchasePayment(
      {required int paymentId, required bool fromWallet});
}

class PaymentDataSourceImpl extends PaymentDataSource {
  final NetworkService _networkService;

  PaymentDataSourceImpl({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() {
    const url = ApiEndPoint.GET_PAYMENT_METHODS;

    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
      final result = response.data;
      return result != null
          ? (result as List).map((e) => PaymentMethodModel.fromMap(e)).toList()
          : [];
    });
  }

  @override
  Future<void> purchasePayment(
      {required int paymentId, required bool fromWallet, String? token}) {
    const url = ApiEndPoint.BOOKING_CONFIRM;
    final data = {
      "paymentMethod": paymentId,
      "walletPayment": fromWallet,
      "token": token,
    };
    return _networkService
        .post(
      url,
      data: data,
    )
        .then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data['detail']);
      }
    });
  }
}
