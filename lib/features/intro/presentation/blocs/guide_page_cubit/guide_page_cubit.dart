import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/models/guide_page_tab_model.dart';
import '../../../data/repositories/intro_repository.dart';

part 'guide_page_state.dart';

const guidePageTabs = [
  GuidePageTabModel(
    description: 'guide1_description',
    title: 'guide1_title',
    image: 'lib/res/assets/guide1.jpg',
  ),
  GuidePageTabModel(
    description: 'guide2_description',
    title: 'guide2_title',
    image: 'lib/res/assets/guide2.jpg',
  ),
  GuidePageTabModel(
    description: 'guide3_description',
    title: 'guide3_title',
    image: 'lib/res/assets/guide3.jpg',
  ),
];

class GuidePageCubit extends BaseCubit<GuidePageState> {
  GuidePageCubit(this._guidePageRepository) : super(const GuidePageState());

  final IntroRepository _guidePageRepository;

  Future<void> loadGuidePage() async {
    try {
      emit(state.copyWith(
        status: GuidePageStateStatus.loaded,
        guidePageTabs: guidePageTabs,
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
