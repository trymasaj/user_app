part of 'service_category_cubit.dart';

enum ServcieCategoryStateStatus { initial, loading, loaded, error }

extension AuthStateX on ServcieCategoryState {
  bool get isInitial => status == ServcieCategoryStateStatus.initial;

  bool get isLoading => status == ServcieCategoryStateStatus.loading;

  bool get isLoaded => status == ServcieCategoryStateStatus.loaded;

  bool get isError => status == ServcieCategoryStateStatus.error;
}

class ServcieCategoryState extends Equatable {
  final ServcieCategoryStateStatus status;
  final List<ServiceCategory> serviceCategories;
  final String? errorMessage;

  const ServcieCategoryState(
      {this.status = ServcieCategoryStateStatus.initial,
      this.serviceCategories = const [],
      this.errorMessage});

  // copy with
  ServcieCategoryState copyWith({
    ServcieCategoryStateStatus? status,
    List<ServiceCategory>? serviceCategories,
    String? errorMessage,
  }) {
    return ServcieCategoryState(
      status: status ?? this.status,
      serviceCategories: serviceCategories ?? this.serviceCategories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, serviceCategories, errorMessage];
}
