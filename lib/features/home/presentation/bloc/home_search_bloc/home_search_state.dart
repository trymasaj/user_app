part of 'home_search_bloc.dart';

enum HomeSearchStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension HomeSearchStateX on HomeSearchState {
  bool get isInitial => status == HomeSearchStateStatus.initial;
  bool get isLoading => status == HomeSearchStateStatus.loading;
  bool get isLoadingMore => status == HomeSearchStateStatus.loadingMore;
  bool get isLoaded => status == HomeSearchStateStatus.loaded;
  bool get isError => status == HomeSearchStateStatus.error;
}

@immutable
class HomeSearchState {
  final Events? eventsData;
  final HomeSearchStateStatus status;
  final String? errorMessage;
  final String? searchText;

  const HomeSearchState({
    this.eventsData,
    this.status = HomeSearchStateStatus.initial,
    this.errorMessage,
    this.searchText,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeSearchState &&
        other.eventsData == eventsData &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.searchText == searchText;
  }

  @override
  int get hashCode =>
      eventsData.hashCode ^ status.hashCode ^ errorMessage.hashCode;

  HomeSearchState copyWith({
    Events? eventsData,
    HomeSearchStateStatus? status,
    String? errorMessage,
    String? searchText,
  }) {
    return HomeSearchState(
      eventsData: eventsData ?? this.eventsData,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      searchText: searchText ?? this.searchText,
    );
  }
}
