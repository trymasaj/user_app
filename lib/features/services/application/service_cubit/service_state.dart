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
  final int? page;
  final int? pageSize;
  final double? priceFrom;
  final double? priceTo;
  final bool? hasReachedMax;
  final ServiceCategory? slectedServiceCategory;
  final List<ServiceCategory>? allServiceCategories;
  const ServcieState(
      {this.status = ServcieStateStatus.initial,
      this.page = 1,
      this.pageSize = 10,
      this.slectedServiceCategory,
      this.allServiceCategories,
      this.hasReachedMax = false,
      this.priceFrom,
      this.priceTo,
      this.services = const [],
      this.errorMessage});

  // copy with
  ServcieState copyWith({
    ServcieStateStatus? status,
    List<ServiceModel>? services,
    ServiceCategory? slectedServiceCategory,
    List<ServiceCategory>? allServiceCategories,
    int? page,
    int? pageSize,
    String? errorMessage,
    double? priceFrom,
    double? priceTo,
    bool? hasReachedMax,
    bool? clearPrice,
  }) {
    return ServcieState(
        status: status ?? this.status,
        services: services ?? this.services,
        errorMessage: errorMessage ?? this.errorMessage,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
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
        allServiceCategories
      ];
}
