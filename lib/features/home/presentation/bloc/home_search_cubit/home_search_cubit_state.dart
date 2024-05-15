part of 'home_search_cubit.dart';

enum HomeSearchStateStatus {
  initial,
  loading,
  loaded,
  error,
}

extension HomeSearchCubitStateX on HomeSearchCubitState {
  bool get isInitial => status == HomeSearchStateStatus.initial;

  bool get isLoading => status == HomeSearchStateStatus.loading;

  bool get isLoaded => status == HomeSearchStateStatus.loaded;

  bool get isError => status == HomeSearchStateStatus.error;
}

class HomeSearchCubitState {
  final HomeSearchStateStatus status;
  final String? errorMessage;
  final HomeSearchResponse? result;
  final List<ServiceModel> recentServices;
  final List<SearchResultModel> recentSearchResults;
  final List<String> recentSearchKeywords;

  const HomeSearchCubitState({
    this.status = HomeSearchStateStatus.initial,
    this.errorMessage,
    this.recentSearchKeywords = const [],
    this.result,
    this.recentServices = const [],
    this.recentSearchResults = const [],
  });

  bool get isEmptyResult {
    return (result?.services ?? []).isEmpty &&
        (result?.therapists ?? []).isEmpty;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSearchCubitState &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.recentSearchKeywords == recentSearchKeywords &&
        other.recentSearchResults == recentSearchResults &&
        other.result == result &&
        other.recentServices == recentServices;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      recentSearchKeywords.hashCode ^
      result.hashCode ^
      recentSearchResults.hashCode ^
      recentServices.hashCode;

  HomeSearchCubitState copyWith({
    HomeSearchStateStatus? status,
    String? errorMessage,
    List<String>? recentSearchKeywords,
    HomeSearchResponse? result,
    List<ServiceModel>? recentServices,
    List<SearchResultModel>? recentSearchResults,
  }) {
    return HomeSearchCubitState(
      status: status ?? this.status,
      recentSearchKeywords: recentSearchKeywords ?? this.recentSearchKeywords,
      errorMessage: errorMessage ?? this.errorMessage,
      result: result ?? this.result,
      recentServices: recentServices ?? this.recentServices,
      recentSearchResults: recentSearchResults ?? this.recentSearchResults,
    );
  }
}
