import 'package:notes_taking_app/src/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    required super.note,
    required super.category,
    required super.dateTime,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      note: json['note'],
      category: json['category'],
      dateTime: json['dateTime'],
    );
  }
  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      note: note.note,
      category: note.category,
      dateTime: note.dateTime,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'note': note,
      'category': category,
      'dateTime': dateTime.toString(),
    };
  }
}
