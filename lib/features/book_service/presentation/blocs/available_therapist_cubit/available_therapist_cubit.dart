import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/book_service/data/models/booking_model/timeslot.dart';
import 'package:masaj/features/book_service/enums/avalable_therapist_tab_enum.dart';
import 'package:masaj/features/providers_tab/data/models/avilable_therapist_model.dart';
import 'package:masaj/features/providers_tab/data/models/provider_query_model.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/providers_tab/data/repositories/providers_tab_repository.dart';
import 'package:masaj/features/providers_tab/enums/taps_enum.dart';

part 'available_therapist_state.dart';

class AvialbleTherapistCubit extends BaseCubit<AvialbleTherapistState> {
  AvialbleTherapistCubit({
    required TherapistsRepository providersTabRepository,
  })  : _providersTabRepository = providersTabRepository,
        super(const AvialbleTherapistState(
            status: AvialbleTherapistStatus.initial));

  final TherapistsRepository _providersTabRepository;

  Future<void> selectTherapist(AvailableTherapistModel? therapist) async {
    emit(state.copyWith(selectedTherapist: therapist));
  }

  void selectTimeSlot(AvailableTherapistModel? timeSlot) {
    emit(state.copyWith(selectedAvailableTimeSlot: timeSlot));
  }

  Future<void> getAvailableTherapists(
      {required DateTime bookingDate,
      required AvailableTherapistTabEnum pickTherapistType}) async {
    emit(state.copyWith(status: AvialbleTherapistStatus.loading));
    try {
      final therapists = await _providersTabRepository.getAvailableTherapists(
          bookingDate: bookingDate, pickTherapistType: pickTherapistType.index);

      emit(state.copyWith(
          status: AvialbleTherapistStatus.loaded,
          availableTherapists: therapists,
          selectedTherapist: therapists.firstOrNull,
          clearTimeSlot: true));
    } catch (e, s) {
      emit(state.copyWith(
          status: e.toString() == "NoAvailableTherapists"
              ? AvialbleTherapistStatus.loaded
              : AvialbleTherapistStatus.error,
          errorMessage: e.toString() == "NoAvailableTherapists"
              ? state.errorMessage
              : e.toString(),
          availableTherapists: e.toString() == 'NoAvailableTherapists'
              ? []
              : state.availableTherapists));
    }
  }

  // get available time slots
  Future<void> getAvailableTimeSlots(DateTime bookingDate) async {
    emit(state.copyWith(timeSlotsStatus: TimeSlotsStatus.loading));
    try {
      final timeSlots = await _providersTabRepository.getAvailableTimeSlots(
          state.selectedTherapist?.therapist?.therapistId ?? 1, bookingDate);
      emit(state.copyWith(
          timeSlotsStatus: TimeSlotsStatus.loaded,
          availableTimeSlots: timeSlots));
    } catch (e) {
      emit(state.copyWith(timeSlotsStatus: TimeSlotsStatus.error));
    }
  }
}
