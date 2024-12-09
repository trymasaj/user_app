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
  final List<HomeSectionModel>? homeSections; 

  const HomeState({
    this.status = HomeStateStatus.initial,
    this.message,
    this.homeData,
    this.homeSections,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeState &&
        other.status == status &&
        other.message == message &&
        other.homeData == homeData &&
        other.homeSections == homeSections;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ homeData.hashCode
  ^ homeSections.hashCode;

  HomeState copyWith({
    HomeStateStatus? status,
    String? appInfo,
    String? message,
    HomeData? homeData,
    List<HomeSectionModel>? homeSections,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      homeData: homeData ?? this.homeData,
      homeSections: homeSections ?? this.homeSections,
    );
  }
}
