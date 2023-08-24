import 'package:flutter/material.dart';
import 'package:notes_taking_app/src/features/notes/domain/entities/note.dart';
import 'package:notes_taking_app/src/features/notes/domain/repository/notes_repository.dart';

class GetNotesUsecase {
  NotesRepository repository;
  GetNotesUsecase({required this.repository});
  Future<List<Note>> execute() async {
    try {
      final notes = repository.getNotes();
      return notes;
    } catch (e) {
      debugPrint('error fetching notes : $e');
      rethrow;
    }
  }
}
