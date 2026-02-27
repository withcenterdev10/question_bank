import 'package:flutter/material.dart';
import 'package:flutter_friday_test/db.dart';
import 'package:flutter_friday_test/repositories/question_repository.dart';
import 'package:flutter_friday_test/router.dart';
import 'package:flutter_friday_test/services/question_service.dart';
import 'package:flutter_friday_test/states/question_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late final QuestionService questionService;
  late final QuestionRepository questionRepository;
  late final QuestionState questionState;

  Future<void> init() async {
    final database = await db();
    questionService = QuestionService(db: database);
    questionRepository = QuestionRepository(service: questionService);
    questionState = QuestionState(repository: questionRepository);
  }

  @override
  initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => questionState,
      child: MaterialApp.router(routerConfig: router),
    );
  }
}
