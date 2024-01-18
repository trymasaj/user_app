part of 'splash_cubit.dart';

enum SplashStateStatus { initial, loading, loaded, error, isRooted }

extension SplashStateX on SplashState {
  bool get isInitial => status == SplashStateStatus.initial;

  bool get isLoading => status == SplashStateStatus.loading;

  bool get isLoaded => status == SplashStateStatus.loaded;

  bool get isError => status == SplashStateStatus.error;

  bool get isRooted => status == SplashStateStatus.isRooted;
}

class SplashState {
  final SplashStateStatus status;
  final String? errorMessage;
  final bool? isFirstLaunch;
  final bool? isLanguageSet;

  const SplashState({
    this.status = SplashStateStatus.initial,
    this.errorMessage,
    this.isFirstLaunch,
    this.isLanguageSet,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as SplashState).status == status &&
        other.errorMessage == errorMessage &&
        other.isFirstLaunch == isFirstLaunch &&
        other.isLanguageSet == isLanguageSet;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      isFirstLaunch.hashCode ^
      isLanguageSet.hashCode;

  SplashState copyWith({
    SplashStateStatus? status,
    String? errorMessage,
    bool? isFirstLaunch,
    bool? isLanguageSet,
  }) {
    return SplashState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      isLanguageSet: isLanguageSet ?? this.isLanguageSet,
    );
  }
}
