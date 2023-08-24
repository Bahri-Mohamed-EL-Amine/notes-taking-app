import 'package:flutter/cupertino.dart';
import 'package:notes_taking_app/src/features/notes/domain/repository/notes_repository.dart';

import '../entities/note.dart';

class InsertNoteUsecase {
  NotesRepository repository;
  InsertNoteUsecase({required this.repository});
  Future<int> execute(Note note) async {
    try {
      final id = repository.addNote(note);
      return id;
    } catch (e) {
      debugPrint('error fetching notes : $e');
      rethrow;
    }
  }
}
