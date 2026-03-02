import "dart:math";
import "package:flutter_friday_test/models/question_model.dart";
import "package:flutter_friday_test/utils/db_util.dart";
import "package:sqlite3/sqlite3.dart";

class QuestionRepository {
  QuestionRepository._();
  static final QuestionRepository _instance = QuestionRepository._();
  static QuestionRepository get instance => _instance;
  final DB _db = DB.instance;

  final rand = Random();

  Future<QuestionModel> createQuestion(QuestionModel question) async {
    final id = rand.nextInt(1000000);
    final db = await _db.connect();

    db.execute(
      "insert into questions (id, question, answer1, answer2, answer3, answer4, correctAnswer) values ('$id', '${question.question}', '${question.answer1}', '${question.answer2}', '${question.answer3}', '${question.answer4}', '${question.correctAnswer}')",
    );
    final newQuestion = await fetchLatest();
    return QuestionModel.fromJson(newQuestion);
  }

  void fetchQuestions() async {
    final db = await _db.connect();
    ResultSet questions = db.select("select * from questions");
    print(questions);
  }

  Future<Row> fetchLatest() async {
    final db = await _db.connect();
    ResultSet question = db.select("select * from questions LIMIT 1");
    return question.single;
  }

  Future<ResultSet> fetchQuestion({required String questionId}) async {
    final db = await _db.connect();
    ResultSet questions = db.select(
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
  }) async {
    final db = await _db.connect();
    db.execute(
      "UPDATE questions SET question = '$question', answer1 = '$answer1', answer2 = '$answer2', answer3 = '$answer3', answer4 = '$answer4', correctAnswer = '$correctAnswer' WHERE id ='$questionId'",
    );

    fetchQuestions();
  }
}
