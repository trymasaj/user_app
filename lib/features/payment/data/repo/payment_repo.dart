import 'package:masaj/features/payment/data/datasource/payment_datasource.dart';
import 'package:masaj/features/payment/data/model/payment_method_model.dart';

abstract class PaymentRepository {
  Future<List<PaymentMethodModel>> getPaymentMethods();
  Future<void> purchasePayment(
      {required int paymentId, required bool fromWallet});
}

class PaymentRepositoryImp extends PaymentRepository {
  final PaymentDataSource _paymentDataSource;

  PaymentRepositoryImp({required PaymentDataSource paymentDataSource})
      : _paymentDataSource = paymentDataSource;

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() =>
      _paymentDataSource.getPaymentMethods();
  @override
  Future<void> purchasePayment(
          {required int paymentId, required bool fromWallet}) =>
      _paymentDataSource.purchasePayment(
          paymentId: paymentId, fromWallet: fromWallet);
}
