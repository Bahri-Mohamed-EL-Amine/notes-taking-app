import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_taking_app/src/features/notes/data/repository/notes_repository_impl.dart';
import 'package:notes_taking_app/src/features/notes/domain/usecase/get_notes_usecase.dart';
import 'package:notes_taking_app/src/features/notes/domain/usecase/insert_note_usecase.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/notes/notes_events.dart';

import '../../../domain/entities/note.dart';

class NotesBloc extends Bloc<NotesEvent, List<Note>> {
  GetNotesUsecase getNotesUsecase =
      GetNotesUsecase(repository: NoteRepositoryImpl());
  InsertNoteUsecase insertNoteUsecase =
      InsertNoteUsecase(repository: NoteRepositoryImpl());
  List<Note> notes = [];
  NotesBloc() : super([]) {
    on<NotesFilterEvent>(onNotesFilterEvent);
    on<NotesFecthAllEvent>(onNotesFetchAllEvent);
    on<NotesAddEvent>(onNotesAddEvent);
    on<NotesSearchEvent>(onNotesSearchEvent);
  }
  bool isNotesFetched = false;
  onNotesSearchEvent(NotesSearchEvent event, Emitter<List<Note>> emit) {
    final filtredNotes = notes.where(
        (element) => element.note.toLowerCase().contains(event.value.trim()));
    emit(List.from(filtredNotes));
  }

  onNotesFetchAllEvent(
      NotesFecthAllEvent event, Emitter<List<Note>> emit) async {
    if (!isNotesFetched) {
      notes = await getNotesUsecase.execute();
      isNotesFetched = true;
    }
    emit(List.from(notes));
  }

  onNotesFilterEvent(NotesFilterEvent event, Emitter<List<Note>> emit) {
    if (event.categorie.compareTo('All') == 0) {
      emit(List.from(notes));
    } else {
      List<Note> filteredNotes = notes
          .where((element) => element.category == event.categorie)
          .toList();
      emit(List.from(filteredNotes));
    }
  }

  onNotesAddEvent(NotesAddEvent event, Emitter<List<Note>> emit) {
    insertNoteUsecase.execute(event.note);
    notes.add(event.note);
    emit(List.from(notes));
  }
}
