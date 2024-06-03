
part of 'review_tips_cubit_state.dart';
enum ReviewTipsStatus { initial, loading, loaded, error, tipsSuccess }
extension ReviewTipsStatusX on ReviewTipsStatus {
  bool get isInitial => this == ReviewTipsStatus.initial;
  bool get isLoading => this == ReviewTipsStatus.loading;
  bool get isLoaded => this == ReviewTipsStatus.loaded;
  bool get isError => this == ReviewTipsStatus.error;
  bool get isTipsSuccess => this == ReviewTipsStatus.tipsSuccess;
}


class ReviewTipsCubitState{
  final ReviewTipsStatus status;
  final String? errorMessage;
  final bool? tipsSuccess;

  const ReviewTipsCubitState({
    this.status = ReviewTipsStatus.initial,
    this.errorMessage,
    this.tipsSuccess,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as ReviewTipsCubitState).status == status &&
        other.errorMessage == errorMessage &&
        other.tipsSuccess == tipsSuccess;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      tipsSuccess.hashCode;

  ReviewTipsCubitState copyWith({
    ReviewTipsStatus? status,
    String? errorMessage,
    bool? tipsSuccess,
  }) {
    return ReviewTipsCubitState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      tipsSuccess: tipsSuccess ?? this.tipsSuccess,
    );
  }
}
