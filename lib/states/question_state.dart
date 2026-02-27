import 'package:flutter/material.dart';
import 'package:flutter_friday_test/models/question_model.dart';
import 'package:flutter_friday_test/repositories/question_repository.dart';

class QuestionState extends ChangeNotifier {
  List<QuestionModel>? state;

  QuestionState({required this.repository});
  QuestionRepository repository;

  void createQuestion({
    required String question,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required String correctAnswer,
  }) {
    final newQuestion = repository.createQuestion(
      question: question,
      answer1: answer1,
      answer2: answer2,
      answer3: answer3,
      answer4: answer4,
      correctAnswer: correctAnswer,
    );

    state = [...?state, newQuestion];
    notifyListeners();
  }
}
