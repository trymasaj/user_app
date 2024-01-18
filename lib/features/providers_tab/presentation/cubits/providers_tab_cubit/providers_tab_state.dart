part of 'providers_tab_cubit.dart';

enum ProvidersTabStateStatus {
  initial,
  loading,
  loaded,
  error,
}

extension ProvidersTabStateX on ProvidersTabState {
  bool get isInitial => status == ProvidersTabStateStatus.initial;

  bool get isLoading => status == ProvidersTabStateStatus.loading;

  bool get isLoaded => status == ProvidersTabStateStatus.loaded;

  bool get isError => status == ProvidersTabStateStatus.error;
}

@immutable
class ProvidersTabState {
  final ProvidersTabStateStatus status;
  final String? errorMessage;

  const ProvidersTabState({
    this.status = ProvidersTabStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as ProvidersTabState).status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ errorMessage.hashCode;

  ProvidersTabState copyWith({
    ProvidersTabStateStatus? status,
    String? errorMessage,
  }) {
    return ProvidersTabState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
