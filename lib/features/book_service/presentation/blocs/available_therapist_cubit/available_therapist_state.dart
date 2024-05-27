part of 'available_therapist_cubit.dart';

enum AvialbleTherapistStatus {
  initial,
  loading,
  loaded,
  error,
  refreshing,
  isLoadingMore
}

enum TimeSlotsStatus { initial, loading, loaded, error }

extension TimeSlotsX on AvialbleTherapistState {
  bool get isTimeSlotsInitial => timeSlotsStatus == TimeSlotsStatus.initial;

  bool get isTimeSlotsLoading => timeSlotsStatus == TimeSlotsStatus.loading;

  bool get isTimeSlotsLoaded => timeSlotsStatus == TimeSlotsStatus.loaded;

  bool get isTimeSlotsError => timeSlotsStatus == TimeSlotsStatus.error;
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
  final TimeSlotsStatus timeSlotsStatus;
  final String? errorMessage;
  final List<AvailableTherapistModel> availableTherapists;
  final AvailableTherapistModel? selectedTherapist;
  final AvailableTherapistModel? selectedAvailableTimeSlot;
  final List<AvailableTimeSlot> availableTimeSlots;

  const AvialbleTherapistState({
    this.status = AvialbleTherapistStatus.initial,
    this.errorMessage,
    this.availableTherapists = const [],
    this.selectedTherapist,
    this.selectedAvailableTimeSlot,
    this.timeSlotsStatus = TimeSlotsStatus.initial,
    this.availableTimeSlots = const [],
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as AvialbleTherapistState).status == status &&
        other.errorMessage == errorMessage &&
        other.availableTherapists == availableTherapists &&
        other.selectedTherapist == selectedTherapist &&
        other.selectedAvailableTimeSlot == selectedAvailableTimeSlot &&
        other.timeSlotsStatus == timeSlotsStatus &&
        other.availableTimeSlots == availableTimeSlots;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      availableTherapists.hashCode ^
      selectedTherapist.hashCode ^
      selectedAvailableTimeSlot.hashCode ^
      timeSlotsStatus.hashCode ^
      availableTimeSlots.hashCode;

  AvialbleTherapistState copyWith({
    AvialbleTherapistStatus? status,
    String? errorMessage,
    List<AvailableTherapistModel>? availableTherapists,
    AvailableTherapistModel? selectedTherapist,
    AvailableTherapistModel? selectedAvailableTimeSlot,
    bool clearTimeSlot = false,
    TimeSlotsStatus? timeSlotsStatus,
    List<AvailableTimeSlot>? availableTimeSlots,
  }) {
    return AvialbleTherapistState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        availableTherapists: availableTherapists ?? this.availableTherapists,
        selectedTherapist: selectedTherapist ?? this.selectedTherapist,
        selectedAvailableTimeSlot: clearTimeSlot
            ? null
            : selectedAvailableTimeSlot ?? this.selectedAvailableTimeSlot,
        timeSlotsStatus: timeSlotsStatus ?? this.timeSlotsStatus,
        availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots);
  }
}
