part of 'home_page_cubit.dart';

enum Status { initial, loading, loaded, error }

extension StatusX on HomePageState {
  bool get isInitial => status == Status.initial;
  bool get isLoading => status == Status.loading;
  bool get isLoaded => status == Status.loaded;
  bool get isError => status == Status.error;
}

class HomePageState {
  final Status status;
  final List<ServiceOffer>? offers;
  final List<ServiceModel>? recommendedServices;
  final List<SessionModel>? repeatedSessions;
  final List<BannerModel>? banners;
  final String? error;

  HomePageState({
    required this.status,
    this.offers,
    this.recommendedServices,
    this.repeatedSessions,
    this.banners,
    this.error,
  });

  factory HomePageState.initial() {
    return HomePageState(
      status: Status.initial,
    );
  }
  // copyWith method
  HomePageState copyWith({
    Status? status,
    List<ServiceOffer>? offers,
    List<ServiceModel>? recommendedServices,
    List<SessionModel>? repeatedSessions,
    List<BannerModel>? banners,
    String? error,
  }) {
    return HomePageState(
      status: status ?? this.status,
      offers: offers ?? this.offers,
      recommendedServices: recommendedServices ?? this.recommendedServices,
      repeatedSessions: repeatedSessions ?? this.repeatedSessions,
      banners: banners ?? this.banners,
      error: error ?? this.error,
    );
  }

  factory HomePageState.loading({
    List<ServiceOffer>? offers,
    List<ServiceModel>? recommendedServices,
    List<SessionModel>? repeatedSessions,
    List<BannerModel>? banners,
  }) {
    return HomePageState(
      status: Status.loading,
      offers: offers,
      recommendedServices: recommendedServices,
      repeatedSessions: repeatedSessions,
      banners: banners,
    );
  }
  @override
  String toString() {
    return 'HomePageState(status: $status, offers: $offers, recommendedServices: $recommendedServices, repeatedSessions: $repeatedSessions, banners: $banners)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomePageState &&
        other.status == status &&
        other.offers == offers &&
        other.recommendedServices == recommendedServices &&
        other.repeatedSessions == repeatedSessions &&
        other.error == error &&
        other.banners == banners;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        offers.hashCode ^
        recommendedServices.hashCode ^
        repeatedSessions.hashCode ^
        error.hashCode ^
        banners.hashCode;
  }
}
