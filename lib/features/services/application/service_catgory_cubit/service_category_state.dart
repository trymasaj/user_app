part of 'service_category_cubit.dart';

enum ServiceCategoryStateStatus { initial, loading, loaded, error }

extension AuthStateX on ServiceCategoryState {
  bool get isInitial => status == ServiceCategoryStateStatus.initial;

  bool get isLoading => status == ServiceCategoryStateStatus.loading;

  bool get isLoaded => status == ServiceCategoryStateStatus.loaded;

  bool get isError => status == ServiceCategoryStateStatus.error;
}

class ServiceCategoryState extends Equatable {
  final ServiceCategoryStateStatus status;
  final List<ServiceCategory> serviceCategories;
  final String? errorMessage;

  const ServiceCategoryState(
      {this.status = ServiceCategoryStateStatus.initial,
      this.serviceCategories = const [],
      this.errorMessage});

  // copy with
  ServiceCategoryState copyWith({
    ServiceCategoryStateStatus? status,
    List<ServiceCategory>? serviceCategories,
    String? errorMessage,
  }) {
    return ServiceCategoryState(
      status: status ?? this.status,
      serviceCategories: serviceCategories ?? this.serviceCategories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, serviceCategories, errorMessage];
}
