part of 'focus_area_cubit.dart';

enum FocusAreaStateStatus {
  initial,
  loading,
  loaded,
  updated,
  error,
}

enum FocusAreaStateType { Front, Back }

extension FocusAreaStateX on FocusAreaState {
  bool get isInitial => status == FocusAreaStateStatus.initial;

  bool get isLoading => status == FocusAreaStateStatus.loading;

  bool get isLoaded => status == FocusAreaStateStatus.loaded;

  bool get isError => status == FocusAreaStateStatus.error;
}

class FocusAreaState {
  final FocusAreaStateStatus status;
  final String? errorMessage;
  final FocusAreaStateType? type;
  Map<FocusAreas, bool> positions;

  FocusAreaState({
    this.status = FocusAreaStateStatus.initial,
    this.errorMessage,
    this.type,
    this.positions = const {},
    th,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as FocusAreaState).status == status &&
        other.type == type &&
        other.positions == positions &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      type.hashCode ^
      positions.hashCode;

  FocusAreaState copyWith({
    FocusAreaStateStatus? status,
    String? errorMessage,
    FocusAreaStateType? type,
    Map<FocusAreas, bool>? positions,
  }) {
    return FocusAreaState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        positions: positions ?? this.positions,
        type: type ?? this.type);
  }
}
