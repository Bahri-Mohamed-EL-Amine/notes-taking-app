import 'package:notes_taking_app/src/features/notes/domain/entities/note.dart';

abstract class NotesEvent {}

class NotesFecthAllEvent extends NotesEvent {}

class NotesAddEvent extends NotesEvent {
  Note note;
  NotesAddEvent({required this.note});
}

class NotesFilterEvent extends NotesEvent {
  String categorie;
  NotesFilterEvent({required this.categorie});
}

class NotesAddCategorieEvent extends NotesEvent {
  String categorie;
  NotesAddCategorieEvent({required this.categorie});
}

class NotesSearchEvent extends NotesEvent {
  String value;
  NotesSearchEvent({required this.value});
}
