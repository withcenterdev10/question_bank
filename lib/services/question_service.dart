import "package:sqlite3/sqlite3.dart";

class QuestionService {
  QuestionService({required this.db});
  Database db;

  void createQuestion({
    required String question,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
  }) {
    // db.insert();
    // insert to database
  }
}
