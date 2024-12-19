import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    _notes = await DatabaseHelper.instance.fetchNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await DatabaseHelper.instance.insertNote(note);
    await loadNotes();
  }

  Future<void> deleteNoteById(int? id) async {
    print("is deleted $id");
    await DatabaseHelper.instance.deleteNoteById(id);
    await loadNotes();
  }
}
