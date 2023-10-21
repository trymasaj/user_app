import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data/models/event.dart';
import '../../../data/repositories/home_repository.dart';

import '../../../../../core/exceptions/redundant_request_exception.dart';

part 'home_search_state.dart';
part 'home_search_event.dart';

class HomeSearchBloc extends Bloc<HomeSearchEvent, HomeSearchState> {
  HomeSearchBloc(this._homeRepository) : super(const HomeSearchState()) {
    on<HomeSearchEvent>(
      (event, emit) async {
        if (event.isSearch)
          await _loadEvents(
            emit,
            searchText: event.searchText,
          );
        if (event.isLoadMore)
          await _loadMoreEvents(
            emit,
            event.searchText,
          );
      },
      transformer: (events, mapper) => events
          .where((event) =>
              event.searchText?.isNotEmpty != true ||
              event.searchText!.length >= 2)
          .debounceTime(const Duration(milliseconds: 500))
          .distinct(
              (previous, next) => !next.isSearch ? false : previous == next)
          .switchMap(mapper),
    );
  }

  final HomeRepository _homeRepository;

  Future<void> _loadEvents(
    Emitter<HomeSearchState> emit, {
    String? searchText,
  }) async {
    try {
      if (searchText?.trim().isNotEmpty != true)
        return emit(
            const HomeSearchState(status: HomeSearchStateStatus.loaded));

      emit(state.copyWith(status: HomeSearchStateStatus.loading));
      final events =
          await _homeRepository.getHomeSearch(text: searchText!.trim());
      emit(state.copyWith(
        status: HomeSearchStateStatus.loaded,
        eventsData: events,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _loadMoreEvents(
    Emitter<HomeSearchState> emit,
    String? searchText,
  ) async {
    if (state.isLoadingMore) return;

    final oldEvents = state.eventsData;
    if (oldEvents?.cursor == null) return;

    try {
      emit(state.copyWith(
        status: HomeSearchStateStatus.loadingMore,
        searchText: searchText,
      ));
      final newEvents = await _homeRepository.getHomeSearch(
        text: searchText!.trim(),
        cursor: oldEvents!.cursor!,
      );
      emit(state.copyWith(
        status: HomeSearchStateStatus.loaded,
        eventsData: newEvents.copyWith(
          events: [
            ...?oldEvents.events,
            ...?newEvents.events,
          ],
        ),
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
        status: HomeSearchStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
