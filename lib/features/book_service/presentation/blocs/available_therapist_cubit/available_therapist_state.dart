part of 'available_therapist_cubit.dart';

enum AvialbleTherapistStatus {
  initial,
  loading,
  loaded,
  error,
  refreshing,
  isLoadingMore
}

extension AvialbleTherapistStateX on AvialbleTherapistState {
  bool get isInitial => status == AvialbleTherapistStatus.initial;

  bool get isLoading => status == AvialbleTherapistStatus.loading;

  bool get isLoaded => status == AvialbleTherapistStatus.loaded;

  bool get isError => status == AvialbleTherapistStatus.error;
  bool get isRefreshing => status == AvialbleTherapistStatus.refreshing;
  bool get isLoadingMore => status == AvialbleTherapistStatus.isLoadingMore;
}

@immutable
class AvialbleTherapistState {
  final AvialbleTherapistStatus status;
  final String? errorMessage;
  final List<AvailableTherapistModel> availableTherapists;
  final AvailableTherapistModel? selectedTherapist;
  final AvailableTherapistModel? selectedAvailableTimeSlot;

  const AvialbleTherapistState({
    this.status = AvialbleTherapistStatus.initial,
    this.errorMessage,
    this.availableTherapists = const [],
    this.selectedTherapist,
    this.selectedAvailableTimeSlot,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as AvialbleTherapistState).status == status &&
        other.errorMessage == errorMessage &&
        other.availableTherapists == availableTherapists
        && other.selectedTherapist == selectedTherapist
        && other.selectedAvailableTimeSlot == selectedAvailableTimeSlot
        ;
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ availableTherapists.hashCode
      ^ selectedTherapist.hashCode ^ selectedAvailableTimeSlot.hashCode

      ;

  AvialbleTherapistState copyWith({
    AvialbleTherapistStatus? status,
    String? errorMessage,
    List<AvailableTherapistModel>? availableTherapists,
    AvailableTherapistModel? selectedTherapist,
    AvailableTherapistModel? selectedAvailableTimeSlot,
    bool clearTimeSlot = false,
  }) {
    return AvialbleTherapistState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        availableTherapists: availableTherapists ?? this.availableTherapists,
        selectedTherapist: selectedTherapist ?? this.selectedTherapist,
        selectedAvailableTimeSlot: 
        clearTimeSlot ? null :
        selectedAvailableTimeSlot ?? this.selectedAvailableTimeSlot,
        );
  }
}
