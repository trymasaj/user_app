import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/account/data/models/points_model.dart';
import 'package:masaj/features/account/data/repositories/account_repository.dart';

part 'points_state.dart';

class PointsCubit extends BaseCubit<PointsState> {
  PointsCubit(this._accountRepository)
      : super(const PointsState(status: PointsStateStatus.initial));

  final AccountRepository _accountRepository;

  Future<void> loadPoints([bool refresh = false]) async {
    try {
      if (!refresh) emit(state.copyWith(status: PointsStateStatus.loading));
      final points = await _accountRepository.getUserPoints();

      emit(
          state.copyWith(status: PointsStateStatus.loaded, pointModel: points));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: PointsStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> refresh() => loadPoints(true);

  Future<void> loadMorePoints() async {
    if (state.pointModel?.cursor == null) return;
    if (state.isLoadingMore) return;
    try {
      emit(state.copyWith(status: PointsStateStatus.loadingMore));

      final points =
          await _accountRepository.getMorePoints(state.pointModel!.cursor!);

      emit(
        state.copyWith(
          status: PointsStateStatus.loaded,
          pointModel: points.copyWith(
              points: [
                ...?state.pointModel?.points,
                ...?points.points,
              ],
              current: state.pointModel?.current,
              total: state.pointModel?.total),
        ),
      );
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
        status: PointsStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
