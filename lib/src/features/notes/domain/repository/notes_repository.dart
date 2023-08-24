import 'package:notes_taking_app/src/features/notes/domain/entities/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotes();
  Future<int> addNote(Note note);
  Future<int> addCategory(String category);
  Future<List<String>> getCategories();
}
