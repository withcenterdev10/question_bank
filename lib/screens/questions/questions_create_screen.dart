import 'package:flutter/material.dart';
import 'package:flutter_friday_test/screens/questions/questions_screen.dart';
import 'package:flutter_friday_test/services/question_service.dart';
import 'package:flutter_friday_test/states/question_state.dart';
import "package:go_router/go_router.dart";

class QuestionsCreateScreen extends StatefulWidget {
  const QuestionsCreateScreen({super.key});

  static const String routeName = "/questions_create";
  static void Function(BuildContext context) go = (context) =>
      context.go(routeName);
  static void Function(BuildContext context) push = (context) =>
      context.push(routeName);

  @override
  State<QuestionsCreateScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsCreateScreen> {
  final formKey = GlobalKey<FormState>();
  final questionController = TextEditingController();
  final answer1Controller = TextEditingController();
  final answer2Controller = TextEditingController();
  final answer3Controller = TextEditingController();
  final answer4Controller = TextEditingController();
  final correctAnswer = TextEditingController();

  @override
  void dispose() {
    questionController.dispose();
    answer1Controller.dispose();
    answer2Controller.dispose();
    answer3Controller.dispose();
    answer4Controller.dispose();
    correctAnswer.dispose();

    super.dispose();
  }

  void onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final question = questionController.text;
      final answer1 = questionController.text;
      final answer2 = questionController.text;
      final answer3 = questionController.text;
      final answer4 = questionController.text;
      final correctAnswer = questionController.text;

      final newQuestion = await QuestionService.instance.createQuestion(
        question: question,
        answer1: answer1,
        answer2: answer2,
        answer3: answer3,
        answer4: answer4,
        correctAnswer: correctAnswer,
      );

      if (context.mounted) {
        QuestionsScreen.go(context);
        QuestionState.of(context).createQuestion(newQuestion);
      }

      formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Question")),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(
            spacing: 6,
            children: [
              TextFormField(
                controller: questionController,
                decoration: InputDecoration(labelText: "Question"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "question is required";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: answer1Controller,
                decoration: InputDecoration(labelText: "Answer 1"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "answer 1 is required";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: answer2Controller,
                decoration: InputDecoration(labelText: "Answer 2"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "answer 2 is required";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: answer3Controller,
                decoration: InputDecoration(labelText: "Answer 3"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "answer 3 is required";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: answer4Controller,
                decoration: InputDecoration(labelText: "Answer 4"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "answer 4 is required";
                  }

                  return null;
                },
              ),

              TextFormField(
                controller: correctAnswer,
                decoration: InputDecoration(labelText: "Correct answer"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "correct answer is required";
                  }

                  return null;
                },
              ),

              ElevatedButton(
                onPressed: () {
                  onSubmit(context);
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
