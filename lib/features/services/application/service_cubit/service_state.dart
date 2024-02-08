part of 'service_cubit.dart';

enum ServiceStateStatus {
  initial,
  loading,
  loaded,
  error,
  loadingMore,
  isRefreshing
}

extension AuthStateX on ServiceState {
  bool get isInitial => status == ServiceStateStatus.initial;

  bool get isLoading => status == ServiceStateStatus.loading;

  bool get isLoaded => status == ServiceStateStatus.loaded;

  bool get isError => status == ServiceStateStatus.error;
  bool get isLoadingMore => status == ServiceStateStatus.loadingMore;
  bool get isRefreshing => status == ServiceStateStatus.isRefreshing;
}

class ServiceState extends Equatable {
  final ServiceStateStatus status;
  final ServicesResponse? services;
  final String? errorMessage;
  final int? page;
  final int? pageSize;
  final double maxPrice;
  final double minPrice;
  final double? priceFrom;
  final double? priceTo;
  final String? searchKeyword;
  final bool? hasReachedMax;
  final ServiceCategory? slectedServiceCategory;
  final List<ServiceCategory>? allServiceCategories;
  const ServiceState(
      {this.status = ServiceStateStatus.initial,
      this.page = 1,
      this.pageSize = 10,
      this.slectedServiceCategory,
      this.maxPrice = 1000,
      this.minPrice = 0,
      this.allServiceCategories,
      this.hasReachedMax = false,
      this.priceFrom,
      this.priceTo,
      this.searchKeyword,
      this.services = ServicesResponse.empty,
      this.errorMessage});

  // copy with
  ServiceState copyWith({
    ServiceStateStatus? status,
    ServicesResponse? services,
    ServiceCategory? selectedServiceCategory,
    List<ServiceCategory>? allServiceCategories,
    int? page,
    int? pageSize,
    String? errorMessage,
    double? priceFrom,
    double? priceTo,
    bool? hasReachedMax,
    bool? clearPrice,
    double? maxPrice,
    double? minPrice,
    bool? isRefreshing,
    bool? isLoadingMore,
    String? searchKeyword,
    bool clearSearch = false,
  }) {
    return ServiceState(
        status: status ?? this.status,
        searchKeyword: clearSearch ? null : searchKeyword ?? this.searchKeyword,
        services: services ?? this.services,
        errorMessage: errorMessage ?? this.errorMessage,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        maxPrice: clearPrice == true ? 1000 : maxPrice ?? this.maxPrice,
        minPrice: clearPrice == true ? 0 : minPrice ?? this.minPrice,
        slectedServiceCategory:
            selectedServiceCategory ?? this.slectedServiceCategory,
        priceFrom: clearPrice == true ? null : priceFrom ?? this.priceFrom,
        priceTo: clearPrice == true ? null : priceTo ?? this.priceTo,
        allServiceCategories:
            allServiceCategories ?? this.allServiceCategories);
  }

  @override
  List<Object?> get props => [
        status,
        services,
        errorMessage,
        page,
        pageSize,
        hasReachedMax,
        priceFrom,
        priceTo,
        slectedServiceCategory,
        allServiceCategories,
        maxPrice,
        minPrice,
        searchKeyword
      ];
}
