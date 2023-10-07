part of 'more_tab_cubit.dart';

enum MoreTabStateStatus {
  initial,
  loading,
  loaded,
  error,
  displayingShowCase,
}

extension MoreTabStateX on MoreTabState {
  bool get isInitial => status == MoreTabStateStatus.initial;
  bool get isLoading => status == MoreTabStateStatus.loading;
  bool get isLoaded => status == MoreTabStateStatus.loaded;
  bool get isError => status == MoreTabStateStatus.error;
  bool get isDisplayingShowCase =>
      status == MoreTabStateStatus.displayingShowCase;
}

@immutable
class MoreTabState {
  final String? appInfo;
  final MoreTabStateStatus status;
  final String? errorMessage;
  final List<ExternalItemModel>? externalSection;

  const MoreTabState({
    this.appInfo,
    this.status = MoreTabStateStatus.initial,
    this.errorMessage,
    this.externalSection,
  });

  MoreTabState copyWith({
    MoreTabStateStatus? status,
    String? errorMessage,
    String? appInfo,
    List<ExternalItemModel>? externalSection,
  }) {
    return MoreTabState(
      status: status ?? this.status,
      appInfo: appInfo ?? this.appInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      externalSection: externalSection ?? this.externalSection,
    );
  }

  @override
  bool operator ==(covariant MoreTabState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.errorMessage == errorMessage &&
        other.appInfo == appInfo &&
        listEquals(other.externalSection, externalSection);
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      appInfo.hashCode ^
      externalSection.hashCode;
}
