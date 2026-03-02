import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_friday_test/db.dart';
import 'package:flutter_friday_test/models/question_model.dart';
import 'package:flutter_friday_test/screens/home/home_screen.dart';
import 'package:flutter_friday_test/screens/questions/question_view_screen.dart';
import 'package:flutter_friday_test/states/question_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sqlite3/sqlite3.dart' hide Row;

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  static const String routeName = "/questions";
  static void Function(BuildContext context) go = (context) =>
      context.go(routeName);
  static void Function(BuildContext context) push = (context) =>
      context.push(routeName);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  Future<void> fetchQuestions() async {
    final database = await db();
    ResultSet res = database.select("select * from questions");
    List<QuestionModel> questions = [];

    if (res.isNotEmpty) {
      for (var question in res) {
        questions.add(QuestionModel.fromJson(question));
      }
    }

    if (mounted) {
      context.read<QuestionState>().setQuestions(questions);
    }
  }

  @override
  initState() {
    super.initState();
    scheduleMicrotask(() {
      fetchQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = context.select<QuestionState, List<QuestionModel>>((p) {
      if (p.state == null) return [];
      return p.state!;
    });
    print("questions: ${questions.length}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Questions"),
        actions: [
          IconButton(
            onPressed: () {
              HomeScreen.go(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ...questions.map((question) {
              return Padding(
                padding: EdgeInsetsGeometry.only(bottom: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text("Question Id: ${question.id}"),
                        Text(question.question),
                        IconButton(
                          onPressed: () {
                            QuestionViewScreen.push(context, question.id!);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(question.answer1),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(question.answer2),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(question.answer3),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(question.answer4),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          question.correctAnswer,
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
