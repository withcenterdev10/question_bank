import "dart:math";

import "package:sqlite3/sqlite3.dart";

class QuestionService {
  QuestionService({required this.db});
  Database db;
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

    db.execute(
      "insert into questions (id, question, answer1, answer2, answer3, answer4, correctAnswer) values ($id, $question, $answer1, $answer2, $answer3, $answer4, $correctAnswer)",
    );

    fetchQuestions();
  }

  void fetchQuestions() {
    ResultSet questions = db.select("select * from questions");
    print(questions);
  }
}
