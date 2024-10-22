import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/data/clients/cache_manager.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/features/intro/data/models/guide_page_tab_model.dart';

part 'guide_page_state.dart';

class GuidePageCubit extends BaseCubit<GuidePageState> {
  GuidePageCubit(this._cacheService) : super(const GuidePageState());

  final CacheManager _cacheService;

  Future<void> loadGuidePage() async {
    try {
      emit(state.copyWith(
        status: GuidePageStateStatus.loaded,
        guidePageTabs: GuidePageTabModel.guidePageTabs,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: GuidePageStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> setFirstLaunchToFalse({required VoidCallback onDone}) async {
    try {
      await _cacheService.setIsFirstLaunch(false);
      onDone();
    } catch (e) {
      log(e.toString());
    }
  }

  void updateTabNumber(int tabNumber) => emit(state.copyWith(
      status: GuidePageStateStatus.tabChanged, tabNumber: tabNumber));
}
