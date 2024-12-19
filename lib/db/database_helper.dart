import 'package:notevault/models/TodoItem.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      content TEXT NOT NULL,
      mood TEXT NOT NULL,
      timestamp TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE todos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      content TEXT NOT NULL,
      completed INTEGER NOT NULL DEFAULT 0
    )
  ''');
  }

  Future<int> insertNote(Note note) async {
    final db = await instance.database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<Note>> fetchNotes() async {
    final db = await instance.database;
    final maps = await db.query('notes');
    return maps.map((map) => Note.fromMap(map)).toList();
  }

  Future<int> deleteNoteById(int? id) async {
    final db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertTodo(Todoitem todo) async {
    final db = await instance.database;
    return await db.insert('todos', todo.toMap());
  }

  Future<int> updateTodo(Todoitem todo) async {
    final db = await instance.database;

    final updatedTodo = {
      'completed': todo.completed ? 1 : 0,
    };

    return await db.update(
      'todos',
      updatedTodo,
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<List<Todoitem>> fetchTodos() async {
    final db = await instance.database;
    final maps = await db.query('todos');
    return maps.map((map) => Todoitem.fromMap(map)).toList();
  }

  Future<int> deleteTodoById(int id) async {
    final db = await instance.database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
