import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/providers_tab/data/repositories/providers_tab_repository.dart';

part 'home_therapists_cubit_state.dart';

class HomeTherapistsCubit extends BaseCubit<HomeTherapistsState> {
  final TherapistsRepository _therapistsRepository;

  HomeTherapistsCubit(this._therapistsRepository)
      : super(const HomeTherapistsState());

  Future<void> getRecommendedTherapists() async {
    print("state.status");
    print(state.status);
    if(state.status == HomeTherapistsStateStatus.loading){
      return;
    }
    emit(state.copyWith(status: HomeTherapistsStateStatus.loading));
    try {
      final therapists = await _therapistsRepository.getRecommended();
      emit(state.copyWith(
          status: HomeTherapistsStateStatus.loaded, therapists: therapists));
    } catch (e) {
      emit(state.copyWith(
          status: HomeTherapistsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> updateTherapist(Therapist therapist) async {
    final index = state.therapists
        .indexWhere((element) => element.therapistId == therapist.therapistId);
    if (index != -1) {
      final therapists = state.therapists;
      therapists[index] = therapist;
      emit(state.copyWith(therapists: [...therapists]));
    }
  }
}
