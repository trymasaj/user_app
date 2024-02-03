part of 'focus_area_cubit.dart';

enum FocusAreaStateStatus {
  initial,
  loading,
  loaded,
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

  const FocusAreaState({
    this.status = FocusAreaStateStatus.initial,
    this.errorMessage,
    this.type,
    th,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as FocusAreaState).status == status &&
        other.type == type &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ type.hashCode;

  FocusAreaState copyWith({
    FocusAreaStateStatus? status,
    String? errorMessage,
    FocusAreaStateType? type,
  }) {
    return FocusAreaState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        type: type);
  }
}
