import "dart:math";

import "package:flutter_friday_test/db.dart";
import "package:sqlite3/sqlite3.dart";

class QuestionService {
  late Database _db;
  QuestionService() {
    initDB();
  }

  Future<void> initDB() async {
    _db = await db();
  }

  final rand = Random();

  void createQuestion({
    required String question,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required String correctAnswer,
  }) {
    final id = rand.nextInt(1000000);

    _db.execute(
      "insert into questions (id, question, answer1, answer2, answer3, answer4, correctAnswer) values ($id, $question, $answer1, $answer2, $answer3, $answer4, $correctAnswer)",
    );

    fetchQuestions();
  }

  void fetchQuestions() {
    ResultSet questions = _db.select("select * from questions");
    print(questions);
  }

  ResultSet fetchQuestion({required String questionId}) {
    ResultSet questions = _db.select(
      "select * from questions WHERE id = $questionId",
    );
    return questions;
  }

  void updateQuestion({
    required String questionId,
    required String question,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required String correctAnswer,
  }) {
    _db.execute(
      "UPDATE questions SET question = '$question', answer1 = '$answer1', answer2 = '$answer2', answer3 = '$answer3', answer4 = '$answer4', correctAnswer = '$correctAnswer' WHERE id ='$questionId'",
    );

    fetchQuestions();
  }
}
