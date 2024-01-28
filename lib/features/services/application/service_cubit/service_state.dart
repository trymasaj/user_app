part of 'service_cubit.dart';

enum ServcieStateStatus { initial, loading, loaded, error }

extension AuthStateX on ServcieState {
  bool get isInitial => status == ServcieStateStatus.initial;

  bool get isLoading => status == ServcieStateStatus.loading;

  bool get isLoaded => status == ServcieStateStatus.loaded;

  bool get isError => status == ServcieStateStatus.error;
}

class ServcieState extends Equatable {
  final ServcieStateStatus status;
  final List<ServiceModel> services;
  final String? errorMessage;

  const ServcieState(
      {this.status = ServcieStateStatus.initial,
      this.services = const [],
      this.errorMessage});

  // copy with
  ServcieState copyWith({
    ServcieStateStatus? status,
    List<ServiceModel>? services,
    String? errorMessage,
  }) {
    return ServcieState(
      status: status ?? this.status,
      services: services ?? this.services,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, services, errorMessage];
}
