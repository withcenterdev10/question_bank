import 'package:flutter/material.dart';
import 'package:flutter_friday_test/screens/questions/questions_create_screen.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "/";
  static void Function(BuildContext context) go = (context) =>
      context.go(routeName);
  static void Function(BuildContext context) push = (context) =>
      context.push(routeName);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            ElevatedButton(
              onPressed: () {
                QuestionsCreateScreen.push(context);
              },
              child: Text("Go to create question page"),
            ),
          ],
        ),
      ),
    );
  }
}
