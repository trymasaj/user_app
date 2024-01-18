import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:masaj/core/data/device/launcher_service.dart';
import 'package:masaj/features/home/data/models/home_data.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/home/data/repositories/home_repository.dart';

import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit(
    this._homeRepository,
    this._launcherService,
  ) : super(const HomeState());

  final HomeRepository _homeRepository;

  final LauncherService _launcherService;

  Future<void> loadHome({
    bool refresh = false,
  }) async {
    try {
      if (!refresh) emit(state.copyWith(status: HomeStateStatus.loading));
      final homeData = await _homeRepository.getHomePageData();

      emit(state.copyWith(
        status: HomeStateStatus.loaded,
        homeData: homeData,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> refresh() => loadHome(refresh: true);

  Future<void> openLink(String link) {
    return _launcherService.openWebsite(link);
  }
}
