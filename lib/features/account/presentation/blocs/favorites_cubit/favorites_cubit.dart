import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/repositories/favorites_repository.dart';
import '../../../../home/data/models/event.dart';

part 'favorites_state.dart';

class FavoritesCubit extends BaseCubit<FavoritesState> {
  FavoritesCubit(this._favoritesRepository)
      : super(const FavoritesState(status: FavoritesStateStatus.initial));
  static const _pageSize = 10;

  final FavoritesRepository _favoritesRepository;

  Future<void> loadFavorites([bool refresh = false]) async {
    try {
      if (!refresh) emit(state.copyWith(status: FavoritesStateStatus.loading));
      final favorites =
          await _favoritesRepository.getFavorites() as List<Event>;

      emit(state.copyWith(
          status: FavoritesStateStatus.loaded, favoritesList: favorites));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FavoritesStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() => loadFavorites(true);

  Future<void> loadMoreFavorites() async {
    if (state.isLoadingMore) return;
    if ((state.favoritesList ?? []).length < _pageSize) return;
    try {
      emit(state.copyWith(status: FavoritesStateStatus.loadingMore));

      final favorites = await _favoritesRepository.getFavorites(
          skip: state.favoritesList?.length ?? 0);

      emit(state.copyWith(
          status: FavoritesStateStatus.loaded,
          favoritesList: [...?state.favoritesList, ...favorites]));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FavoritesStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<bool> removeFromFav(int id, [int? index]) async {
    var previousState = state;
    try {
      await _favoritesRepository.removeFromFav(id);
      List<Event> copiedList = [...previousState.favoritesList ?? []];

      if (index != null) copiedList.removeAt(index);

      emit(state.copyWith(
          status: FavoritesStateStatus.loaded, favoritesList: copiedList));

      return true;
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FavoritesStateStatus.error, errorMessage: e.toString()));
      return false;
    }
  }

  Future<bool> addToFav(int id) async {
    try {
      await _favoritesRepository.addToFav(id);

      return true;
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FavoritesStateStatus.error, errorMessage: e.toString()));
      return false;
    }
  }
}
