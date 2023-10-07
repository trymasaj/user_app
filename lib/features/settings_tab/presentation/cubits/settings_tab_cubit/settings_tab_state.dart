part of 'settings_tab_cubit.dart';

enum SettingsTabStateStatus {
  initial,
  loading,
  loaded,
  error,
}

extension SettingsTabStateX on SettingsTabState {
  bool get isInitial => status == SettingsTabStateStatus.initial;
  bool get isLoading => status == SettingsTabStateStatus.loading;
  bool get isLoaded => status == SettingsTabStateStatus.loaded;
  bool get isError => status == SettingsTabStateStatus.error;
}

@immutable

class SettingsTabState {
  final SettingsTabStateStatus status;
  final String? errorMessage;

  const SettingsTabState({
    this.status = SettingsTabStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as SettingsTabState).status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>  status.hashCode ^ errorMessage.hashCode;

  SettingsTabState copyWith({
    SettingsTabStateStatus? status,
    String? errorMessage,
  }) {
    return SettingsTabState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}