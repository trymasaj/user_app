part of 'book_service_cubit.dart';

enum BookServiceStatus {
  initial,
  loading,
  loaded,
  error,
  refreshing,
  isLoadingMore
}

extension BookServiceStateX on BookServiceState {
  bool get isInitial => status == BookServiceStatus.initial;

  bool get isLoading => status == BookServiceStatus.loading;

  bool get isLoaded => status == BookServiceStatus.loaded;

  bool get isError => status == BookServiceStatus.error;
  bool get isRefreshing => status == BookServiceStatus.refreshing;
  bool get isLoadingMore => status == BookServiceStatus.isLoadingMore;
}

@immutable
class BookServiceState {
  final BookServiceStatus status;
  final String? errorMessage;
  final List<Therapist> therapists;
  final Therapist? selectedTherapist;
  final TherapistTabsEnum selectedTab;
  final int? page;
  final int? pageSize;
  final BookingModel? bookingModel;
  List<Therapist> get therapistsList => therapists
      .where((element) => selectedTab == TherapistTabsEnum.favorites
          ? element.isFavourite ?? false
          : true)
      .toList();

  const BookServiceState({
    this.status = BookServiceStatus.initial,
    this.errorMessage,
    this.therapists = const [],
    this.selectedTab = TherapistTabsEnum.all,
    this.page,
    this.selectedTherapist,
    this.pageSize = 10,
    this.bookingModel,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as BookServiceState).status == status &&
        other.errorMessage == errorMessage &&
        other.therapists == therapists &&
        other.selectedTherapist == selectedTherapist &&
        other.selectedTab == selectedTab &&
        other.page == page &&
        other.pageSize == pageSize &&
        other.bookingModel == bookingModel;
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
      bookingModel.hashCode;

  BookServiceState copyWith({
    BookServiceStatus? status,
    String? errorMessage,
    List<Therapist>? therapists,
    TherapistTabsEnum? selectedTab,
    int? page,
    int? pageSize,
    bool clearSeach = false,
    Therapist? selectedTherapist,
    BookingModel? bookingModel,
  }) {
    return BookServiceState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        therapists: therapists ?? this.therapists,
        selectedTab: selectedTab ?? this.selectedTab,
        page: page ?? this.page,
        selectedTherapist: selectedTherapist ?? this.selectedTherapist,
        pageSize: pageSize ?? this.pageSize,
        bookingModel: bookingModel ?? this.bookingModel);
  }
}
