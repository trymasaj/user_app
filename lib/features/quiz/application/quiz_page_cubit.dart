import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/quiz/domain/entities/question.dart';
import 'package:masaj/features/quiz/domain/repositories/quiz_repo.dart';

part 'quiz_page_state.dart';


class QuizPageCubit extends BaseCubit<QuizPageState> {
  QuizPageCubit(this._repo) : super(QuizPageState.initial());

  final QuizRepo _repo;

  Future<void> submitQuiz(String userId) async {
    try {
      await _repo.submitQuiz(userId, state.questions);
      emit(state.copyWith(result: QuizSubmitResult.success));
    } catch (e) {
      emit(state.copyWith(result: QuizSubmitResult.failed));
      rethrow;
    }
  }

  Future<void> skipQuiz(String userId) async {
    await _repo.skipQuiz(userId);
    emit(state.copyWith(result: QuizSubmitResult.success));
  }

  void updateQuestionIndex(int questionIndex) =>
      emit(state.copyWith(questionIndex: questionIndex));

  void onNextPressed(String userId, Question question) {
    if (state.questionIndex == state.questions.questions.length - 1) {
      submitQuiz(userId);
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

  onChangedSomethingElse(String value) {
    final questions = state.questions.questions;
    questions[state.questionIndex] = questions[state.questionIndex].copyWith(
        selectedAnswer: some(Answer.someThingElse().copyWith(
      content: value,
    )));
    emit(state.copyWith(questions: Questions(questions: questions)));
  }
}
