import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/providers_tab/data/models/provider_query_model.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/providers_tab/data/repositories/providers_tab_repository.dart';
import 'package:masaj/features/providers_tab/enums/taps_enum.dart';

part 'providers_tab_state.dart';

class ProvidersTabCubit extends BaseCubit<ProvidersTabState> {
  ProvidersTabCubit({
    required TherapistsRepository providersTabRepository,
  })  : _providersTabRepository = providersTabRepository,
        super(const ProvidersTabState(status: ProvidersTabStateStatus.initial));

  final TherapistsRepository _providersTabRepository;

  // select tab
  Future<void> selectTab(TherapistTabsEnum tab) async {
    emit(state.copyWith(selectedTab: tab));
    await getTherapists();
  }

  // search
  Future<void> search(String keyword) async {
    emit(state.copyWith(searchKeyword: keyword));
    await getTherapists();
  }

  // get therapists
  Future<void> getTherapists({
    bool refresh = false,
  }) async {
    if (state.isLoading) return;
    if (refresh) {
      emit(state.copyWith(status: ProvidersTabStateStatus.refreshing));
    } else {
      emit(state.copyWith(status: ProvidersTabStateStatus.loading));
    }

    try {
      final therapists = await _providersTabRepository.getTherapistsByTabs(
        ProvideQueryModel(
          tabFilter: state.selectedTab,
          page: 1,
          pageSize: state.pageSize,
          searchKeyword: state.searchKeyword,
        ),
      );
      emit(state.copyWith(
        status: ProvidersTabStateStatus.loaded,
        therapists: therapists.data,
        page: 1,
        searchKeyword: state.searchKeyword,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProvidersTabStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // load more therapists
  Future<void> loadMoreTherapists() async {
    if (state.isLoading) return;
    if (state.therapists.length < (state.pageSize ?? 10)) return;
    emit(state.copyWith(status: ProvidersTabStateStatus.isLoadingMore));
    try {
      final therapists = await _providersTabRepository.getTherapistsByTabs(
        ProvideQueryModel(
          tabFilter: state.selectedTab,
          page: state.page! + 1,
          pageSize: state.pageSize,
        ),
      );
      emit(state.copyWith(
        status: ProvidersTabStateStatus.loaded,
        therapists: [...state.therapists, ...(therapists.data ?? [])],
        page: state.page! + 1,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProvidersTabStateStatus.error,
        errorMessage: e.toString(),
      ));
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
