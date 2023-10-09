part of 'quiz_page_cubit.dart';

enum QuizPageStateStatus { initial, loading, loaded, error, tabChanged }

extension QuizPageStateX on QuizPageState {
  bool get isInitial => status == QuizPageStateStatus.initial;
  bool get isLoading => status == QuizPageStateStatus.loading;
  bool get isLoaded => status == QuizPageStateStatus.loaded;
  bool get isError => status == QuizPageStateStatus.error;
  bool get isTabChanged => status == QuizPageStateStatus.tabChanged;
}

@immutable
class QuizPageState {
  final List<QuizPageTabModel> QuizPageTabs;
  final QuizPageStateStatus status;
  final String? errorMessage;
  final int tabNumber;

  const QuizPageState({
    this.QuizPageTabs = const [],
    this.status = QuizPageStateStatus.initial,
    this.errorMessage,
    this.tabNumber = 0,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as QuizPageState).status == status &&
        other.errorMessage == errorMessage &&
        listEquals(other.QuizPageTabs, QuizPageTabs) &&
        other.tabNumber == tabNumber;
  }

  @override
  int get hashCode =>
      QuizPageTabs.hashCode ^
      status.hashCode ^
      errorMessage.hashCode ^
      tabNumber.hashCode;

  QuizPageState copyWith({
    QuizPageStateStatus? status,
    String? errorMessage,
    List<QuizPageTabModel>? QuizPageTabs,
    int? tabNumber,
  }) {
    return QuizPageState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      QuizPageTabs: QuizPageTabs ?? this.QuizPageTabs,
      tabNumber: tabNumber ?? this.tabNumber,
    );
  }
}
