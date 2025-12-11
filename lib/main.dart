import 'package:quiz_api/pages/register_page.dart';
import 'package:quiz_api/pages/todo_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/":(context)=>RegisterPage(),
        "/to-do":(context)=>TodoPage(),
      },
      initialRoute: "/",
    );
  }
}