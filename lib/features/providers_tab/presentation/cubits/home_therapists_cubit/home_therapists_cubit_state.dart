part of 'home_therapists_cubit.dart';

enum HomeTherapistsStateStatus { initial, loading, loaded, error }

extension HomeTherapistsStateX on HomeTherapistsState {
  bool get isInitial => status == HomeTherapistsStateStatus.initial;

  bool get isLoading => status == HomeTherapistsStateStatus.loading;

  bool get isLoaded => status == HomeTherapistsStateStatus.loaded;

  bool get isError => status == HomeTherapistsStateStatus.error;
}

class HomeTherapistsState {
  final HomeTherapistsStateStatus status;
  final List<Therapist> therapists;
  final String? errorMessage;

  const HomeTherapistsState(
      {this.status = HomeTherapistsStateStatus.initial,
      this.therapists = const [],
      this.errorMessage});

  // copy with
  HomeTherapistsState copyWith({
    HomeTherapistsStateStatus? status,
    List<Therapist>? therapists,
    String? errorMessage,
  }) {
    return HomeTherapistsState(
      status: status ?? this.status,
      therapists: [...therapists ?? this.therapists],
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  int get hashCode =>
      status.hashCode ^ therapists.hashCode ^ errorMessage.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeTherapistsState &&
        other.status == status &&
        other.therapists == therapists &&
        other.errorMessage == errorMessage;
  }
}
