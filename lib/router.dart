import 'package:flutter/material.dart';
import 'package:flutter_friday_test/screens/home/home_screen.dart';
import 'package:flutter_friday_test/screens/questions/question_view_screen.dart';
import 'package:flutter_friday_test/screens/questions/questions_create_screen.dart';
import 'package:flutter_friday_test/screens/questions/questions_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: QuestionsScreen.routeName,
  routes: [
    GoRoute(
      path: HomeScreen.routeName,
      builder: (BuildContext context, GoRouterState state) => HomeScreen(),
    ),
    GoRoute(
      path: QuestionsCreateScreen.routeName,
      builder: (BuildContext context, GoRouterState state) =>
          QuestionsCreateScreen(),
    ),
    GoRoute(
      path: QuestionsScreen.routeName,
      builder: (BuildContext context, GoRouterState state) => QuestionsScreen(),
    ),
    GoRoute(
      path: QuestionViewScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return QuestionViewScreen(
          questionId: state.pathParameters['questionId']!,
        );
      },
    ),
  ],
);
