import 'package:flutter/material.dart';
import 'package:flutter_friday_test/states/user_state.dart';
import 'package:flutter_friday_test/widgets/page_wrapper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_friday_test/states/user_state.dart";
// import "package:sqflite/sqflite.dart";

import 'package:sqlite3/sqlite3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  late final Database db;

  @override
  initState() {
    super.initState();
    _initDB();
  }

  Future<void> _initDB() async {
    final libraryDir = await getLibraryDirectory();

    db = sqlite3.open(join(libraryDir.path, 'test.db'));

    // db.execute(
    //   "CREATE TABLE users (id varchar(64), password text, name varchar(64) )",
    // );

    // insert
    db.execute("insert into users (id, password, name) values ('a', 'b', 'c')");

    // update
    // db.execute("UPDATE users SET name = 'updated' where id='a'");

    // delete
    // db.execute("DELETE from users where name='updated'");

    ResultSet res = db.select("select * from users");

    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserState(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,

          title: Text(widget.title),
        ),
        body: PageWrapper(
          child: Center(
            child: Column(
              spacing: 8,
              mainAxisAlignment: .center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                ElevatedButton(
                  onPressed: () {
                    db.execute(
                      "insert into users (id, password, name) values ('b', '${nameController.text}', 'c')",
                    );
                  },
                  child: Text("Submit"),
                ),
                const Text('You have pushed the button this many times:'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
