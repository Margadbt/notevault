// main.dart
import 'package:flutter/material.dart';
import 'package:notevault/clear_database.dart';
import 'package:notevault/providers/todo_provider.dart';
import 'package:provider/provider.dart';
import 'providers/notes_provider.dart';
import 'screens/intro_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()..loadNotes()),
        ChangeNotifierProvider(create: (_) => TodoProvider()..loadTodos()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes and Mood Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: IntroScreen(),
    );
  }
}
