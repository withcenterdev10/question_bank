import 'package:flutter_friday_test/models/question_model.dart';
import 'package:flutter_friday_test/repositories/question_repository.dart';

class QuestionService {
  QuestionService._();
  static final QuestionService _instance = QuestionService._();
  static QuestionService get instance => _instance;
  final QuestionRepository _repository = QuestionRepository.instance;

  Future<QuestionModel> createQuestion({
    required String question,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required String correctAnswer,
  }) {
    final newQuestion = QuestionModel(
      question: question,
      answer1: answer1,
      answer2: answer2,
      answer3: answer3,
      answer4: answer4,
      correctAnswer: correctAnswer,
    );

    return _repository.createQuestion(newQuestion);
  }

  void updateQuestion(
    QuestionModel model, {
    required String questionId,
    required String question,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required String correctAnswer,
  }) {
    // service.updateQuestion(
    //   questionId: questionId,
    //   question: question,
    //   answer1: answer1,
    //   answer2: answer2,
    //   answer3: answer3,
    //   answer4: answer4,
    //   correctAnswer: correctAnswer,
    // );

    // return model.copyWith(
    //   question: question,
    //   answer1: answer1,
    //   answer2: answer2,
    //   answer3: answer3,
    //   answer4: answer4,
    //   correctAnswer: correctAnswer,
    // );
  }

  void fetchQuestion({required String questionId}) {
    // final question = service.fetchQuestion(questionId: questionId);
    // return QuestionModel.fromJson(question[0]);
  }
}
