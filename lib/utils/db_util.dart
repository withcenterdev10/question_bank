import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class DB {
  DB._(); // named constructor
  static final DB _instance = DB._();
  static DB get instance => _instance;

  Database? _db;

  Future<Database> connect() async {
    if (_db != null) {
      return _db!;
    }

    final appDocumentDir = await getApplicationDocumentsDirectory();
    _db = sqlite3.open(join(appDocumentDir.path, 'questions3.db'));
    _db!.execute(
      "CREATE TABLE if not exists questions55 (id varchar(64), question text, answer1 text, answer2 text, answer3 text, answer4 text, correctAnswer text )",
    );

    return _db!;
  }
}
