import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> clearDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'notes.db'); // Specify the name of your database

  try {
    await deleteDatabase(path); // Deletes the database file
    print('Database cleared successfully.');
  } catch (e) {
    print('Error clearing the database: $e');
  }
}
