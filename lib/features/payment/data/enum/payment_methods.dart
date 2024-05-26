enum PaymentMethodType {
  CreditCard,
  Knet,
  ApplePay,
  Wallet,
}

extension PaymentTypesExtension on PaymentMethodType {
  int get getIndex => index + 1;
}
