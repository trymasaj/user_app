import 'package:masaj/core/domain/exceptions/app_exception.dart';

sealed class DataLoadState<T extends Object?> {
  const DataLoadState();

  const factory DataLoadState.loading() = DataLoadLoadingState;

  factory DataLoadState.loaded(T data) = DataLoadLoadedState<T>;

  bool get isLoaded => this is DataLoadLoadedState<T>;

  const factory DataLoadState.error([AppException? err]) = DataLoadErrorState;

  const factory DataLoadState.empty() = DataLoadEmptyState;

  const factory DataLoadState.initial() = DataLoadInitialState;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataLoadState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class DataLoadEmptyState<T extends Object?> extends DataLoadState<T> {
  const DataLoadEmptyState();
}

class DataLoadInitialState<T extends Object?> extends DataLoadState<T> {
  const DataLoadInitialState();
}

class DataLoadLoadingState<T extends Object?> extends DataLoadState<T> {
  const DataLoadLoadingState();
}

class DataLoadLoadedState<T extends Object?> extends DataLoadState<T> {
  final T data;

  const DataLoadLoadedState(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataLoadLoadedState &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class DataLoadErrorState<T extends Object?> extends DataLoadState<T> {
  final AppException? err;

  const DataLoadErrorState([this.err]);
}
