part of 'guide_page_cubit.dart';

enum GuidePageStateStatus { initial, loading, loaded, error }

extension GuidePageStateX on GuidePageState {
  bool get isInitial => status == GuidePageStateStatus.initial;
  bool get isLoading => status == GuidePageStateStatus.loading;
  bool get isLoaded => status == GuidePageStateStatus.loaded;
  bool get isError => status == GuidePageStateStatus.error;
}

@immutable
class GuidePageState {
  final List<GuidePageTabModel> guidePageTabs;
  final GuidePageStateStatus status;
  final String? errorMessage;
  final int tabNumber;

  const GuidePageState({
    this.guidePageTabs = const [],
    this.status = GuidePageStateStatus.initial,
    this.errorMessage,
    this.tabNumber = 0,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as GuidePageState).status == status &&
        other.errorMessage == errorMessage &&
        listEquals(other.guidePageTabs, guidePageTabs) &&
        other.tabNumber == tabNumber;
  }

  @override
  int get hashCode =>
      guidePageTabs.hashCode ^
      status.hashCode ^
      errorMessage.hashCode ^
      tabNumber.hashCode;

  GuidePageState copyWith({
    GuidePageStateStatus? status,
    String? errorMessage,
    List<GuidePageTabModel>? guidePageTabs,
    int? tabNumber,
  }) {
    return GuidePageState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      guidePageTabs: guidePageTabs ?? this.guidePageTabs,
      tabNumber: tabNumber ?? this.tabNumber,
    );
  }
}
