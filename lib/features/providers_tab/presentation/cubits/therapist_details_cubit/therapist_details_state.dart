part of 'therapist_details_cubit.dart';

// state

enum TherapistDetailsStateStatus { initial, loading, loaded, error }

extension TherapistDetailsStateX on TherapistDetailsState {
  bool get isInitial => status == TherapistDetailsStateStatus.initial;

  bool get isLoading => status == TherapistDetailsStateStatus.loading;

  bool get isLoaded => status == TherapistDetailsStateStatus.loaded;

  bool get isError => status == TherapistDetailsStateStatus.error;
}

class TherapistDetailsState extends Equatable {
  final TherapistDetailsStateStatus status;
  final Therapist? therapist;
  final String? errorMessage;
  final bool? isFav;

  const TherapistDetailsState(
      {this.status = TherapistDetailsStateStatus.initial,
      this.therapist,
      this.isFav,
      this.errorMessage});

  // copy with
  TherapistDetailsState copyWith({
    TherapistDetailsStateStatus? status,
    Therapist? therapist,
    String? errorMessage,
    bool? isFav,
  }) {
    return TherapistDetailsState(
      status: status ?? this.status,
      therapist: therapist ?? this.therapist,
      errorMessage: errorMessage ?? this.errorMessage,
      isFav: isFav ?? this.isFav,
    );
  }

  @override
  List<Object?> get props => [status, therapist, errorMessage, isFav];
}
