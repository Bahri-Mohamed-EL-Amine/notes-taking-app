import 'package:notes_taking_app/src/features/notes/data/datasources/locale/notes_database_service.dart';
import 'package:notes_taking_app/src/features/notes/domain/entities/note.dart';
import 'package:notes_taking_app/src/features/notes/domain/repository/notes_repository.dart';

class NoteRepositoryImpl extends NotesRepository {
  @override
  Future<List<Note>> getNotes() async {
    final notes = await DatabaseHelper.instance.fetchNotes();
    return notes;
  }

  @override
  Future<int> addNote(Note note) async {
    final id = await DatabaseHelper.instance.insert(note);
    return id;
  }

  @override
  Future<int> addCategory(String category) async {
    final id = await DatabaseHelper.instance.insertCategory(category);
    return id;
  }

  @override
  Future<List<String>> getCategories() async {
    final categoires = await DatabaseHelper.instance.fetchCategories();
    return categoires;
  }
}
