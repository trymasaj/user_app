part of 'home_cubit.dart';

enum HomeStateStatus {
  initial,
  loading,
  loaded,
  treasureHuntSuccess,
  error,
}

extension HomeStateX on HomeState {
  bool get isInitial => status == HomeStateStatus.initial;
  bool get isLoading => status == HomeStateStatus.loading;
  bool get isLoaded => status == HomeStateStatus.loaded;

  bool get isError => status == HomeStateStatus.error;
}

@immutable
class HomeState {
  final HomeStateStatus status;
  final String? message;
  final HomeData? homeData;

  const HomeState({
    this.status = HomeStateStatus.initial,
    this.message,
    this.homeData,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeState &&
        other.status == status &&
        other.message == message &&
        other.homeData == homeData;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ homeData.hashCode;

  HomeState copyWith({
    HomeStateStatus? status,
    String? appInfo,
    String? message,
    HomeData? homeData,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      homeData: homeData ?? this.homeData,
    );
  }
}
