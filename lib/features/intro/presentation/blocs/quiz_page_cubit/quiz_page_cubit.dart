import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:masaj/features/intro/data/models/question_model.dart';
import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/exceptions/redundant_request_exception.dart';
import '../../../data/models/quiz_page_tab_model.dart';
import '../../../data/repositories/intro_repository.dart';

part 'quiz_page_state.dart';

class QuizPageCubit extends BaseCubit<QuizPageState> {
  QuizPageCubit(this._repo) : super(QuizPageState.initial());

  final IntroRepository _repo;

  Future<void> submitQuiz() async {
    try {
      await _repo.submitQuiz(state.questions);
      emit(state.copyWith(result: QuizSubmitResult.success));
    } catch (e) {
      emit(state.copyWith(result: QuizSubmitResult.failed));
    }
  }

  Future<void> skipQuiz() async {
    await _repo.skipQuiz();
    emit(state.copyWith(result: QuizSubmitResult.success));
  }

  void updateQuestionIndex(int questionIndex) =>
      emit(state.copyWith(questionIndex: questionIndex));

  void onNextPressed(Question question) {
    if (state.questionIndex == state.questions.questions.length - 1) {
      submitQuiz();
    } else {
      updateQuestionIndex(state.questionIndex + 1);
    }
  }

  void onAnswerSelected(Answer answer) {
    final questions = state.questions.questions;
    questions[state.questionIndex] =
        questions[state.questionIndex].copyWith(selectedAnswer: some(answer));
    emit(state.copyWith(questions: Questions(questions: questions)));
  }

  void onBackButtonPressed() {
    if (state.questionIndex != 0) {
      updateQuestionIndex(state.questionIndex - 1);
    }
  }
}
