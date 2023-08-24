import 'package:flutter/cupertino.dart';
import 'package:notes_taking_app/src/features/notes/domain/repository/notes_repository.dart';

class GetCategoriesUsecase {
  NotesRepository repository;
  GetCategoriesUsecase({required this.repository});
  Future<List<String>> execute() async {
    try {
      final notes = repository.getCategories();
      return notes;
    } catch (e) {
      debugPrint('error fetching notes : $e');
      rethrow;
    }
  }
}
