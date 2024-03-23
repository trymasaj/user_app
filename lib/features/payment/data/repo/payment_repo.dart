import 'package:masaj/features/payment/data/datasource/payment_datasource.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';

abstract class PaymentRepository {
  Future<List<PaymentMethodModel>> getPaymentMethods();
}

class PaymentRepositoryImp extends PaymentRepository {
  final PaymentDataSource _paymentDataSource;

  PaymentRepositoryImp({required PaymentDataSource paymentDataSource})
      : _paymentDataSource = paymentDataSource;

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() =>
      _paymentDataSource.getPaymentMethods();
}
