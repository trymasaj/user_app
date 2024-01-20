import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/presentation/constants/image_constant.dart';
import 'package:masaj/features/intro/data/models/guide_page_tab_model.dart';
import 'package:masaj/features/intro/data/repositories/intro_repository.dart';

part 'guide_page_state.dart';

class GuidePageCubit extends BaseCubit<GuidePageState> {
  GuidePageCubit(this._guidePageRepository) : super(const GuidePageState());

  final IntroRepository _guidePageRepository;

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
      await _guidePageRepository.setFirstLaunchToFalse();
      onDone();
    } catch (e) {
      log(e.toString());
    }
  }

  void updateTabNumber(int tabNumber) => emit(state.copyWith(
      status: GuidePageStateStatus.tabChanged, tabNumber: tabNumber));
}
