import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';

abstract class PaymentDataSource {
  Future<List<PaymentMethodModel>> getPaymentMethods();
}

class PaymentDataSourceImpl extends PaymentDataSource {
  final NetworkService _networkService;

  PaymentDataSourceImpl({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() {
    const url = ApiEndPoint.GET_PAYMENT_METHODS;

    return Future.delayed(Duration(seconds: 2)).then((value) => [
          PaymentMethodModel(
              id: 0, isSelected: false, name: 'Credit card', url: ''),
          PaymentMethodModel(
              id: 0, isSelected: false, name: 'Apple Pay', url: ''),
          PaymentMethodModel(id: 0, isSelected: false, name: 'KNet', url: ''),
        ]);
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      return result != null
          ? (result as List).map((e) => PaymentMethodModel.fromMap(e)).toList()
          : [];
    });
  }
}