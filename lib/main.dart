// main.dart
import 'package:flutter/material.dart';
import 'package:notevault/clear_database.dart';
import 'package:notevault/providers/todo_provider.dart';
import 'package:notevault/screens/home_screen.dart';
import 'package:notevault/screens/pin_code_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'providers/notes_provider.dart';
import 'screens/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()..loadNotes()),
        ChangeNotifierProvider(create: (_) => TodoProvider()..loadTodos()),
      ],
      child: MyApp(isFirstLaunch: isFirstLaunch),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  MyApp({super.key, required this.isFirstLaunch});

  final FlutterSecureStorage _storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes and Mood Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isFirstLaunch ? const IntroScreen() : PinCodeScreen(),
    );
  }
}
