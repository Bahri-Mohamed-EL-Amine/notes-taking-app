import 'package:flutter/cupertino.dart';
import 'package:notes_taking_app/src/features/notes/domain/repository/notes_repository.dart';

class InsertCategoryUsecase {
  NotesRepository repository;
  InsertCategoryUsecase({required this.repository});
  Future<int> execute(String category) async {
    try {
      final id = repository.addCategory(category);
      return id;
    } catch (e) {
      debugPrint('error inserting category : $e');
      rethrow;
    }
  }
}
