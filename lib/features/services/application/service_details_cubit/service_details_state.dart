
part of 'service_details_cubit.dart';

// state

enum ServiceDetailsStateStatus { initial, loading, loaded, error }

extension AuthStateX on ServiceDetailsState {
  bool get isInitial => status == ServiceDetailsStateStatus.initial;

  bool get isLoading => status == ServiceDetailsStateStatus.loading;

  bool get isLoaded => status == ServiceDetailsStateStatus.loaded;

  bool get isError => status == ServiceDetailsStateStatus.error;
}

class ServiceDetailsState extends Equatable {
  final ServiceDetailsStateStatus status;
  final ServiceModel? service;
  final String? errorMessage;

  const ServiceDetailsState(
      {this.status = ServiceDetailsStateStatus.initial,
       this.service,
      this.errorMessage});

  // copy with
  ServiceDetailsState copyWith({
    ServiceDetailsStateStatus? status,
    ServiceModel? service,
    String? errorMessage,
  }) {
    return ServiceDetailsState(
      status: status ?? this.status,
      service: service ?? this.service,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, service, errorMessage];
}

