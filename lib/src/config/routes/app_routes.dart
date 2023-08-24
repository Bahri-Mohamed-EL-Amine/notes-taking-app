import 'package:flutter/material.dart';
import 'package:notes_taking_app/src/features/notes/presentation/screens/add_note_screen.dart';
import 'package:notes_taking_app/src/features/notes/presentation/screens/notes_screen.dart';

class AppRoutes {
  static const initalRoute = '/';
  static const addNoteRoute = '/addNote';
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initalRoute:
        return MaterialPageRoute(builder: ((context) => const NotesScreen()));
      case addNoteRoute:
        return MaterialPageRoute(builder: ((context) => const AddNoteScreen()));
      default:
        return null;
    }
  }
}
