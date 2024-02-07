part of 'service_cubit.dart';

enum ServcieStateStatus {
  initial,
  loading,
  loaded,
  error,
  loadingMore,
  isRefreshing
}

extension AuthStateX on ServcieState {
  bool get isInitial => status == ServcieStateStatus.initial;

  bool get isLoading => status == ServcieStateStatus.loading;

  bool get isLoaded => status == ServcieStateStatus.loaded;

  bool get isError => status == ServcieStateStatus.error;
  bool get isLoadingMore => status == ServcieStateStatus.loadingMore;
  bool get isRefreshing => status == ServcieStateStatus.isRefreshing;
}

class ServcieState extends Equatable {
  final ServcieStateStatus status;
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
  const ServcieState(
      {this.status = ServcieStateStatus.initial,
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
  ServcieState copyWith({
    ServcieStateStatus? status,
    ServicesResponse? services,
    ServiceCategory? slectedServiceCategory,
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
    return ServcieState(
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
            slectedServiceCategory ?? this.slectedServiceCategory,
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
