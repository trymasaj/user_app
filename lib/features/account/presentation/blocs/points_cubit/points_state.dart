part of 'points_cubit.dart';

enum PointsStateStatus {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
}

extension PointsStateX on PointsState {
  bool get isInitial => status == PointsStateStatus.initial;

  bool get isLoading => status == PointsStateStatus.loading;

  bool get isLoaded => status == PointsStateStatus.loaded;

  bool get isLoadingMore => status == PointsStateStatus.loadingMore;

  bool get isError => status == PointsStateStatus.error;
}

@immutable
class PointsState {
  final PointsStateStatus status;
  final String? errorMessage;

  final PointsModel? pointModel;

  const PointsState({
    required this.status,
    this.errorMessage,
    this.pointModel,
  });

  PointsState copyWith({
    PointsStateStatus? status,
    String? errorMessage,
    PointsModel? pointModel,
  }) {
    return PointsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      pointModel: pointModel ?? this.pointModel,
    );
  }

  @override
  bool operator ==(covariant PointsState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.errorMessage == errorMessage &&
        other.pointModel == pointModel;
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ pointModel.hashCode;
}
