import 'package:path/path.dart';
import 'package:sqlite3/sqlite3.dart';
import "package:path_provider/path_provider.dart";

Future<Database> db() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  final database = sqlite3.open(join(appDocumentDir.path, 'questions2.db'));
  database.execute(
    "CREATE TABLE questions99 (id varchar(64), question text, answer1 text, answer2 text, answer3 text, answer4 text, correctAnswer text )",
  );
  return database;
}
