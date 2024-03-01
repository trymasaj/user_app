part of 'providers_tab_cubit.dart';

enum ProvidersTabStateStatus {
  initial,
  loading,
  loaded,
  error,
  refreshing,
  isLoadingMore
}

extension ProvidersTabStateX on ProvidersTabState {
  bool get isInitial => status == ProvidersTabStateStatus.initial;

  bool get isLoading => status == ProvidersTabStateStatus.loading;

  bool get isLoaded => status == ProvidersTabStateStatus.loaded;

  bool get isError => status == ProvidersTabStateStatus.error;
  bool get isRefreshing => status == ProvidersTabStateStatus.refreshing;
  bool get isLoadingMore => status == ProvidersTabStateStatus.isLoadingMore;
}

@immutable
class ProvidersTabState {
  final ProvidersTabStateStatus status;
  final String? errorMessage;
  final List<Therapist> therapists;
  final TherapistTabsEnum selectedTab;
  final int? page;
  final int? pageSize;
  final String? searchKeyword;
  List<Therapist> get therapistsList => therapists
      .where((element) => selectedTab == TherapistTabsEnum.favourite
          ? element.isFavourite ?? false
          : true)
      .toList();

  const ProvidersTabState({
    this.status = ProvidersTabStateStatus.initial,
    this.errorMessage,
    this.therapists = const [],
    this.selectedTab = TherapistTabsEnum.all,
    this.page,
    this.pageSize = 10,
    this.searchKeyword,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as ProvidersTabState).status == status &&
        other.errorMessage == errorMessage &&
        other.therapists == therapists &&
        other.selectedTab == selectedTab &&
        other.searchKeyword == searchKeyword &&
        other.page == page &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      therapists.hashCode ^
      selectedTab.hashCode ^
      page.hashCode ^
      pageSize.hashCode ^
      searchKeyword.hashCode;

  ProvidersTabState copyWith({
    ProvidersTabStateStatus? status,
    String? errorMessage,
    List<Therapist>? therapists,
    TherapistTabsEnum? selectedTab,
    int? page,
    int? pageSize,
    String? searchKeyword,
    bool clearSeach = false,
  }) {
    return ProvidersTabState(
        status: status ?? this.status,
        searchKeyword: clearSeach ? null : searchKeyword ?? this.searchKeyword,
        errorMessage: errorMessage ?? this.errorMessage,
        therapists: therapists ?? this.therapists,
        selectedTab: selectedTab ?? this.selectedTab,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize);
  }
}
