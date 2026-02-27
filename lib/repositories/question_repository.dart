import 'package:flutter_friday_test/models/question_model.dart';
import 'package:flutter_friday_test/services/question_service.dart';

class QuestionRepository {
  QuestionRepository({required this.service});

  QuestionService service;

  QuestionModel createQuestion({
    required String question,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required String correctAnswer,
  }) {
    service.createQuestion(
      question: question,
      answer1: answer1,
      answer2: answer2,
      answer3: answer3,
      answer4: answer4,
      correctAnswer: correctAnswer,
    );

    return QuestionModel(
      question: question,
      answer1: answer1,
      answer2: answer2,
      answer3: answer3,
      answer4: answer4,
      correctAnswer: correctAnswer,
    );
  }
}
