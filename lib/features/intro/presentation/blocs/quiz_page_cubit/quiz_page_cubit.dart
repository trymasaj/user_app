import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/models/quiz_page_tab_model.dart';
import '../../../data/repositories/intro_repository.dart';

part 'quiz_page_state.dart';

const QuizPageTabs = [
  QuizPageTabModel(
    questionTitle: 'question1_title',
    options: [
      'question1_answer1',
      'question1_answer2',
    ],
  ),
  QuizPageTabModel(
    questionTitle: 'question2_title',
    options: [
      'question2_answer1',
      'question2_answer2',
      'question2_answer3',
    ],
  ),
  QuizPageTabModel(
    questionTitle: 'question3_title',
    options: [
      'question3_answer1',
      'question3_answer2',
      'question3_answer3',
    ],
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
