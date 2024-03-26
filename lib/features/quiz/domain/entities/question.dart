import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Questions {
  final List<Question> questions;

  Questions({required this.questions});

  factory Questions.getQuestions() {
    return Questions(
      questions: [
        Question(
            id: '1',
            content: 'question1_title',
            answers: [
              Answer(content: 'question1_answer1', id: '1'),
              Answer(content: 'question1_answer2', id: '2'),
            ],
            selectedAnswer: none()),
        Question(
            id: '2',
            content: 'question2_title',
            answers: [
              Answer(content: 'question2_answer1', id: '3'),
              Answer(content: 'question2_answer2', id: '4'),
              Answer(content: 'question2_answer3', id: '5'),
            ],
            selectedAnswer: none()),
        Question(
            id: '3',
            content: 'question3_title',
            answers: [
              Answer(content: 'question3_answer1', id: '6'),
              Answer(content: 'question3_answer2', id: '7'),
              Answer.someThingElse(),
            ],
            selectedAnswer: none()),
      ],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quizAnswers': questions.map((e) => e.toMap()).toList(),
    };
  }
}

class Question with EquatableMixin {
  final String content, id;
  final List<Answer> answers;
  final Option<Answer> selectedAnswer;

  bool get isAnswered => selectedAnswer.isSome();

  Question(
      {required this.id,
      required this.content,
      required this.answers,
      required this.selectedAnswer});

  Question copyWith({
    String? content,
    String? id,
    List<Answer>? answers,
    Option<Answer>? selectedAnswer,
  }) {
    return Question(
      content: content ?? this.content,
      id: id ?? this.id,
      answers: answers ?? this.answers,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }

// to map
  Map<String, dynamic> toMap() {
    return {
      'question': content,
      'answer': selectedAnswer.toNullable()!.content
    };
  }

  @override
  List<Object?> get props => [id];
}

class Answer with EquatableMixin {
  final String content, id;

  Answer({
    required this.id,
    required this.content,
  });

  bool get isSomethingElse => id == '8';

  @override
  List<Object?> get props => [id];

  factory Answer.someThingElse() =>
      Answer(id: '8', content: 'question3_answer3');

  Answer copyWith({
    String? content,
    String? id,
  }) {
    return Answer(
      content: content ?? this.content,
      id: id ?? this.id,
    );
  }
}
