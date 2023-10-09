import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/models/quiz_page_tab_model.dart';
import '../../../data/repositories/intro_repository.dart';

part 'quiz_page_state.dart';

const QuizPageTabs = [
  QuizPageTabModel(
    description: 'Quiz1_description',
    title: 'Quiz1_title',
    image: 'lib/res/assets/Quiz1.jpg',
  ),
  QuizPageTabModel(
    description: 'Quiz2_description',
    title: 'Quiz2_title',
    image: 'lib/res/assets/Quiz2.jpg',
  ),
  QuizPageTabModel(
    description: 'Quiz3_description',
    title: 'Quiz3_title',
    image: 'lib/res/assets/Quiz3.jpg',
  ),
];

class QuizPageCubit extends BaseCubit<QuizPageState> {
  QuizPageCubit(this._QuizPageRepository) : super(const QuizPageState());

  final IntroRepository _QuizPageRepository;

  Future<void> loadQuizPage() async {
    try {
      emit(state.copyWith(
        status: QuizPageStateStatus.loaded,
        QuizPageTabs: QuizPageTabs,
      ));
    } on RedundantRequestException catch (e) {
      log(e.toString());
    } catch (e) {
      emit(state.copyWith(
          status: QuizPageStateStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> setQuizCompletedToTrue({required VoidCallback onDone}) async {
    try {
      await _QuizPageRepository.setQuizCompletedToTrue();
      onDone();
    } catch (e) {
      log(e.toString());
    }
  }

  void updateTabNumber(int tabNumber) => emit(state.copyWith(
      status: QuizPageStateStatus.tabChanged, tabNumber: tabNumber));
}
