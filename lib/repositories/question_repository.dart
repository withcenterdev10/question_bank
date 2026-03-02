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
      "insert into $tableName (id, question, answer1, answer2, answer3, answer4, correctAnswer) values ('$id', '${question.question}', '${question.answer1}', '${question.answer2}', '${question.answer3}', '${question.answer4}', '${question.correctAnswer}')",
    );
    return await fetchLatest();
  }

  Future<QuestionModel> updateQuestion(QuestionModel question) async {
    final db = await _db.connect();
    db.execute(
      "UPDATE $tableName SET question = '${question.question}', answer1 = '${question.answer1}', answer2 = '${question.answer2}', answer3 = '${question.answer3}', answer4 = '${question.answer4}', correctAnswer = '${question.correctAnswer}' WHERE id ='${question.id}'",
    );
    return await fetchQuestionById(question.id!);
  }

  Future<QuestionModel> fetchLatest() async {
    final db = await _db.connect();
    ResultSet question = db.select("select * from $tableName LIMIT 1");
    return QuestionModel.fromJson(question.single);
  }

  Future<QuestionModel> fetchQuestionById(String id) async {
    final db = await _db.connect();
    ResultSet question = db.select("select * from $tableName WHERE id=$id");
    return QuestionModel.fromJson(question.single);
  }

  Future<ResultSet> fetchQuestion({required String questionId}) async {
    final db = await _db.connect();
    ResultSet questions = db.select(
      "select * from $tableName WHERE id = $questionId",
    );
    return questions;
  }

  Future<List<QuestionModel>> fetchQuestions() async {
    final db = await _db.connect();
    ResultSet res = db.select("select * from $tableName");

    List<QuestionModel> questions = [];

    if (res.isNotEmpty) {
      for (var question in res) {
        questions.add(QuestionModel.fromJson(question));
      }
    }

    return questions;
  }
}
