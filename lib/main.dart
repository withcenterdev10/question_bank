import 'package:flutter/material.dart';
import 'package:flutter_friday_test/db.dart';
import 'package:flutter_friday_test/repositories/question_repository.dart';
import 'package:flutter_friday_test/router.dart';
import 'package:flutter_friday_test/services/question_service.dart';
import 'package:flutter_friday_test/states/question_state.dart';
import 'package:provider/provider.dart';

void main() {
  final questionService = QuestionService();
  final questionRepository = QuestionRepository(service: questionService);

  runApp(
    ChangeNotifierProvider(
      create: (context) => QuestionState(repository: questionRepository),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
