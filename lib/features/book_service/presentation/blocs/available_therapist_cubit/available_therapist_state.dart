part of 'available_therapist_cubit.dart';

enum AvialbleTherapistStatus {
  initial,
  loading,
  loaded,
  error,
  refreshing,
  isLoadingMore
}

extension AvialbleTherapistStateX on AvialbleTherapistState {
  bool get isInitial => status == AvialbleTherapistStatus.initial;

  bool get isLoading => status == AvialbleTherapistStatus.loading;

  bool get isLoaded => status == AvialbleTherapistStatus.loaded;

  bool get isError => status == AvialbleTherapistStatus.error;
  bool get isRefreshing => status == AvialbleTherapistStatus.refreshing;
  bool get isLoadingMore => status == AvialbleTherapistStatus.isLoadingMore;
}

@immutable
class AvialbleTherapistState {
  final AvialbleTherapistStatus status;
  final String? errorMessage;
  final List<Therapist> therapists;
  final Therapist? selectedTherapist; 
  final TherapistTabsEnum selectedTab;
  final int? page;
  final int? pageSize;
  final String? searchKeyword;
  List<Therapist> get therapistsList => therapists
      .where((element) => selectedTab == TherapistTabsEnum.favorites
          ? element.isFavourite ?? false
          : true)
      .toList();

  const AvialbleTherapistState({
    this.status = AvialbleTherapistStatus.initial,
    this.errorMessage,
    this.therapists = const [],
    this.selectedTab = TherapistTabsEnum.all,
    this.page,
    this.selectedTherapist,
    this.pageSize = 10,
    this.searchKeyword,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as AvialbleTherapistState).status == status &&
        other.errorMessage == errorMessage &&
        other.therapists == therapists &&
        other.selectedTherapist == selectedTherapist &&
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
      selectedTherapist.hashCode ^
      pageSize.hashCode ^
      searchKeyword.hashCode;

  AvialbleTherapistState copyWith({
    AvialbleTherapistStatus? status,
    String? errorMessage,
    List<Therapist>? therapists,
    TherapistTabsEnum? selectedTab,
    int? page,
    int? pageSize,
    String? searchKeyword,
    bool clearSeach = false,
    Therapist? selectedTherapist,
  }) {
    return AvialbleTherapistState(
        status: status ?? this.status,
        searchKeyword: clearSeach ? null : searchKeyword ?? this.searchKeyword,
        errorMessage: errorMessage ?? this.errorMessage,
        therapists: therapists ?? this.therapists,
        selectedTab: selectedTab ?? this.selectedTab,
        page: page ?? this.page,
        selectedTherapist: selectedTherapist ?? this.selectedTherapist,
        pageSize: pageSize ?? this.pageSize);
  }
}
