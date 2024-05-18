part of 'payment_cubit.dart';

enum PaymentStateStatus {
  initial,
  loading,
  loaded,
  getMethods,
  error,
  deleted,
  walletPayment,
  added,
  paying
}

extension PaymentStateX on PaymentState {
  bool get isInitial => status == PaymentStateStatus.initial;
  bool get isLoading => status == PaymentStateStatus.loading;
  bool get isLoaded => status == PaymentStateStatus.loaded;
  bool get isError => status == PaymentStateStatus.error;
  bool get isDeleted => status == PaymentStateStatus.deleted;
  bool get isAdded => status == PaymentStateStatus.added;
  bool get isWalletPayment => status == PaymentStateStatus.walletPayment;
  bool get isGetMethods => status == PaymentStateStatus.getMethods;
}

class PaymentState {
  final PaymentStateStatus status;
  final String? errorMessage;
  final List<PaymentMethodModel>? methods;
  final PaymentMethodModel? selectedMethod;

  const PaymentState(
      {this.status = PaymentStateStatus.initial,
      this.errorMessage,
      this.methods,
      this.selectedMethod});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as PaymentState).status == status &&
        other.errorMessage == errorMessage &&
        listEquals(other.methods, methods) &&
        other.selectedMethod == selectedMethod;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      Object.hashAll(methods ?? []) ^
      selectedMethod.hashCode;

  PaymentState copyWith(
      {PaymentStateStatus? status,
      String? errorMessage,
      PaymentMethodModel? selectedMethod,
      List<PaymentMethodModel>? methods}) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedMethod: selectedMethod ?? this.selectedMethod,
      methods: methods ?? this.methods,
    );
  }
}
