import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/providers_tab/data/repositories/providers_tab_repository.dart';

part "therapist_details_state.dart";

// cubit
class TherapistDetailsCubit extends BaseCubit<TherapistDetailsState> {
  TherapistDetailsCubit(this._therapistRepository)
      : super(const TherapistDetailsState());
  final TherapistsRepository _therapistRepository;

  void setTherapist(Therapist therapist) {
    emit(state.copyWith(
        therapist: therapist, isFav: therapist.isFavourite ?? false));
  }

  Future<void> toggleFav() async {
    final oldTherapist = state.therapist;
    final newTherapist = oldTherapist?.copyWith(
      isFavourite: !(oldTherapist.isFavourite ?? false),
    );
    try {
      if (oldTherapist != null) {
        emit(state.copyWith(
            therapist: newTherapist,
            isFav: newTherapist?.isFavourite ?? false));
        await _therapistRepository.favTherapist(
          oldTherapist.therapistId ?? 0,
          !(oldTherapist.isFavourite ?? false),
        );
      }
    } catch (e) {
      emit(state.copyWith(
        status: TherapistDetailsStateStatus.error,
        errorMessage: e.toString(),
        isFav: oldTherapist?.isFavourite ?? false,
        therapist: oldTherapist,
      ));
    }
  }

  Future<void> getTherapistDetails(int id) async {
    emit(state.copyWith(
      status: TherapistDetailsStateStatus.loading,
    ));
    try {
      final therapist = await _therapistRepository.getSingleTherapist(id);
      emit(state.copyWith(
        status: TherapistDetailsStateStatus.loaded,
        therapist: therapist,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TherapistDetailsStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
