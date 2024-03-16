part of 'payment_cubit.dart';

enum PaymentStateStatus { initial, loading, loaded, error, deleted, added }

extension PaymentStateX on PaymentState {
  bool get isInitial => status == PaymentStateStatus.initial;
  bool get isLoading => status == PaymentStateStatus.loading;
  bool get isLoaded => status == PaymentStateStatus.loaded;
  bool get isError => status == PaymentStateStatus.error;
  bool get isDeleted => status == PaymentStateStatus.deleted;
  bool get isAdded => status == PaymentStateStatus.added;
}

class PaymentState {
  final PaymentStateStatus status;
  final String? errorMessage;

  const PaymentState({
    this.status = PaymentStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as PaymentState).status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ errorMessage.hashCode;

  PaymentState copyWith(
      {PaymentStateStatus? status,
      String? errorMessage,
      MemberModel? selectedMember,
      List<MemberModel>? members}) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
