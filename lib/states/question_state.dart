import 'package:flutter/material.dart';
import 'package:flutter_friday_test/models/question_model.dart';
import 'package:flutter_friday_test/repositories/question_repository.dart';

class QuestionState extends ChangeNotifier {
  List<QuestionModel>? state;
  QuestionModel? selectedQuestion;

  QuestionState({required this.repository});
  QuestionRepository repository;

  void clearState() {
    selectedQuestion = null;
    notifyListeners();
  }

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

  void setQuestions(List<QuestionModel> questions) {
    print("Setting questions: ${questions.length}");
    state = questions;
    notifyListeners();
  }

  QuestionModel fetchQuestion(String questionId) {
    final question = repository.fetchQuestion(questionId: questionId);
    selectedQuestion = question;
    notifyListeners();
    return question;
  }

  void updatedQuestion({
    required String questionId,
    required String question,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required String correctAnswer,
  }) {
    final updatedQuestion = repository.updateQuestion(
      selectedQuestion!,
      questionId: questionId,
      question: question,
      answer1: answer1,
      answer2: answer2,
      answer3: answer3,
      answer4: answer4,
      correctAnswer: correctAnswer,
    );

    final updatedQuestionList = state!.map((question) {
      if (question.id == questionId) {
        return updatedQuestion;
      } else {
        return question;
      }
    }).toList();

    state = updatedQuestionList;
    notifyListeners();
  }
}
