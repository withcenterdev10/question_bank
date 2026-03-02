import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_friday_test/screens/home/home_screen.dart';
import 'package:flutter_friday_test/screens/questions/questions_screen.dart';
import 'package:flutter_friday_test/services/question_service.dart';
import 'package:flutter_friday_test/states/question_state.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class QuestionViewScreen extends StatefulWidget {
  const QuestionViewScreen({super.key, required this.questionId});
  final String questionId;

  static const String routeName = "/questions/:questionId";
  static void Function(BuildContext context, String id) go =
      (context, String id) =>
          context.go(routeName.replaceFirst(":questionId", id));
  static void Function(BuildContext context, String id) push =
      (context, String id) =>
          context.push(routeName.replaceFirst(":questionId", id));

  @override
  State<QuestionViewScreen> createState() => _QuestionViewScreenState();
}

class _QuestionViewScreenState extends State<QuestionViewScreen> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController questionController;
  late final TextEditingController answer1Controller;
  late final TextEditingController answer2Controller;
  late final TextEditingController answer3Controller;
  late final TextEditingController answer4Controller;
  late final TextEditingController correctAnswerController;

  @override
  initState() {
    super.initState();

    scheduleMicrotask(() async {
      final question = await QuestionService.instance.fetchQuestion(
        widget.questionId,
      );

      if (mounted) {
        QuestionState.of(context).setSelectedQuestion(question);
      }

      questionController = TextEditingController(text: question.question);
      answer1Controller = TextEditingController(text: question.answer1);
      answer2Controller = TextEditingController(text: question.answer2);
      answer3Controller = TextEditingController(text: question.answer3);
      answer4Controller = TextEditingController(text: question.answer4);
      correctAnswerController = TextEditingController(
        text: question.correctAnswer,
      );
    });
  }

  @override
  void dispose() {
    questionController.dispose();
    answer1Controller.dispose();
    answer2Controller.dispose();
    answer3Controller.dispose();
    answer4Controller.dispose();
    correctAnswerController.dispose();
    super.dispose();
  }

  void onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final question = questionController.text;
      final answer1 = answer1Controller.text;
      final answer2 = answer2Controller.text;
      final answer3 = answer3Controller.text;
      final answer4 = answer4Controller.text;
      final correctAnswer = correctAnswerController.text;

      final updatedQuestion = await QuestionService.instance.updateQuestion(
        questionId: widget.questionId,
        question: question,
        answer1: answer1,
        answer2: answer2,
        answer3: answer3,
        answer4: answer4,
        correctAnswer: correctAnswer,
      );

      if (context.mounted) {
        formKey.currentState!.reset();
        QuestionState.of(context).updatedQuestion(updatedQuestion);
        QuestionState.of(context).clearSelectedQuestion();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Question updated")));
        QuestionsScreen.go(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSet = context.select<QuestionState, bool>((p) {
      if (p.selectedQuestion != null) {
        return false;
      } else {
        return true;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("View Question ${widget.questionId}"),
        actions: [
          IconButton(
            onPressed: () {
              HomeScreen.go(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: isSet
          ? CircularProgressIndicator()
          : Form(
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
                      controller: correctAnswerController,
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
