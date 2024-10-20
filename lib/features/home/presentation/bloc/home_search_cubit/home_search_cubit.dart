import 'dart:developer';

import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/home/data/models/home_search_reponse.dart';
import 'package:masaj/features/home/data/repositories/home_repository.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

part 'home_search_cubit_state.dart';

class HomeSearchCubit extends BaseCubit<HomeSearchCubitState> {
  HomeSearchCubit({
    required HomeRepository homeRepository,
  })  : _homeRepository = homeRepository,
        super(const HomeSearchCubitState()) {
    getRecentServices();
    getRecentSearchKeyWords();
    getRecentSearchResults();
  }

  final HomeRepository _homeRepository;

  Future<void> saveRecentService(ServiceModel service) async {
    try {
      final result = await _homeRepository.saveRecentService(service);
      if (result) {
        emit(state.copyWith(
          recentServices: [
            service,
            ...state.recentServices
              ..removeWhere((element) => element.serviceId == service.serviceId)
          ],
        ));
      } else {
        emit(state.copyWith(
          status: HomeSearchStateStatus.error,
          errorMessage: 'Failed to save service',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> saveRecentSearchResult(SearchResultModel service) async {
    try {
      final result = await _homeRepository.saveSearchResult(service);
      if (result) {
        emit(state.copyWith(
          recentSearchResults: [
            service,
            ...state.recentSearchResults
              ..removeWhere((element) =>
                  element.id == service.id && element.type == service.type)
          ],
        ));
      } else {
        emit(state.copyWith(
          status: HomeSearchStateStatus.error,
          errorMessage: 'Failed to save service',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getRecentSearchResults() async {
    emit(state.copyWith(status: HomeSearchStateStatus.loading));
    try {
      final recentSearchResults =
          await _homeRepository.getRecentSearchResults();
      emit(state.copyWith(
        status: HomeSearchStateStatus.loaded,
        recentSearchResults: recentSearchResults,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> removeRecentSearchResult(SearchResultModel service) async {
    emit(state.copyWith(status: HomeSearchStateStatus.loading));
    try {
      final result = await _homeRepository.removeRecentSearchResult(service);
      if (result) {
        final recentSearchResults =
            await _homeRepository.getRecentSearchResults();
        emit(state.copyWith(
          status: HomeSearchStateStatus.loaded,
          recentSearchResults: recentSearchResults,
        ));
      } else {
        emit(state.copyWith(
          status: HomeSearchStateStatus.error,
          errorMessage: 'Failed to remove service',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getRecentServices() async {
    emit(state.copyWith(status: HomeSearchStateStatus.loading));
    try {
      final recentServices = await _homeRepository.getRecentServices();
      emit(state.copyWith(
        status: HomeSearchStateStatus.loaded,
        recentServices: recentServices,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // get recent key words
  Future<void> getRecentSearchKeyWords() async {
    emit(state.copyWith(status: HomeSearchStateStatus.loading));
    try {
      final recentSearchKeywords = await _homeRepository.getSearchKeyWords();
      emit(state.copyWith(
        status: HomeSearchStateStatus.loaded,
        recentSearchKeywords: recentSearchKeywords,
      ));
      //print('recentSearchKeywords: $recentSearchKeywords');
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // remove search key word
  Future<void> removeSearchKeyWord(String keyWord) async {
    emit(state.copyWith(status: HomeSearchStateStatus.loading));
    try {
      final result = await _homeRepository.removeSearchKeyWord(keyWord);
      if (result) {
        final recentSearchKeywords = await _homeRepository.getSearchKeyWords();
        emit(state.copyWith(
          status: HomeSearchStateStatus.loaded,
          recentSearchKeywords: recentSearchKeywords,
        ));
      } else {
        emit(state.copyWith(
          status: HomeSearchStateStatus.error,
          errorMessage: 'Failed to remove service',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // save search key word
  Future<void> saveSearchKeyWord(String keyWord) async {
    emit(state.copyWith(status: HomeSearchStateStatus.loading));
    try {
      final result = await _homeRepository.saveSearchKeyWord(keyWord);
      if (result) {
        final recentSearchKeywords = await _homeRepository.getSearchKeyWords();
        emit(state.copyWith(
          status: HomeSearchStateStatus.loaded,
          recentSearchKeywords: recentSearchKeywords,
        ));
      } else {
        emit(state.copyWith(
          status: HomeSearchStateStatus.error,
          errorMessage: 'Failed to remove service',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // removeRecentService
  Future<void> removeRecentService(ServiceModel service) async {
    emit(state.copyWith(status: HomeSearchStateStatus.loading));
    try {
      final result = await _homeRepository.removeRecentService(service);
      if (result) {
        final recentServices = await _homeRepository.getRecentServices();
        emit(state.copyWith(
          status: HomeSearchStateStatus.loaded,
          recentServices: recentServices,
        ));
      } else {
        emit(state.copyWith(
          status: HomeSearchStateStatus.error,
          errorMessage: 'Failed to remove service',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> search(String keyword) async {
    if (keyword.trim().isEmpty) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.loaded,
        result: HomeSearchResponse.empty,
      ));
      return;
    }

    emit(state.copyWith(status: HomeSearchStateStatus.loading));
    try {
      final homeSearchResponse = await _homeRepository.search(keyWord: keyword);
      emit(state.copyWith(
        status: HomeSearchStateStatus.loaded,
        result: homeSearchResponse,
      ));
    } on RedundantRequestException {
      log('Redundant request');
      emit(state.copyWith(status: HomeSearchStateStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
