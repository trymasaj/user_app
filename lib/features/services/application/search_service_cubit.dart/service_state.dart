part of 'service_cubit.dart';

enum SearchServcieStateStatus { initial, loading, loaded, error }

extension AuthStateX on SearchServcieState {
  bool get isInitial => status == SearchServcieStateStatus.initial;

  bool get isLoading => status == SearchServcieStateStatus.loading;

  bool get isLoaded => status == SearchServcieStateStatus.loaded;

  bool get isError => status == SearchServcieStateStatus.error;
}

class SearchServcieState extends Equatable {
  final SearchServcieStateStatus status;
  final List<ServiceModel> services;
  final String? errorMessage;
  final int? page;
  final int? pageSize;
  final bool? hasReachedMax;
  final ServiceCategory? slectedServiceCategory;
  final List<ServiceCategory>? allServiceCategories;
  const SearchServcieState(
      {this.status = SearchServcieStateStatus.initial,
      this.page = 1,
      this.pageSize = 10,
      this.slectedServiceCategory,
      this.allServiceCategories,
      this.hasReachedMax = false,
      this.services = const [],
      this.errorMessage});

  // copy with
  SearchServcieState copyWith({
    SearchServcieStateStatus? status,
    List<ServiceModel>? services,
    ServiceCategory? slectedServiceCategory,
    List<ServiceCategory>? allServiceCategories,
    int? page,
    int? pageSize,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return SearchServcieState(
        status: status ?? this.status,
        services: services ?? this.services,
        errorMessage: errorMessage ?? this.errorMessage,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        slectedServiceCategory:
            slectedServiceCategory ?? this.slectedServiceCategory,
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
        slectedServiceCategory,
        allServiceCategories
      ];
}
