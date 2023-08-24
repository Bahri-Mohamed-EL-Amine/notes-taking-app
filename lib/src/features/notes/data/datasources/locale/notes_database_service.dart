import 'package:notes_taking_app/src/features/notes/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../domain/entities/note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes2.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const dateType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE notes (
        id $idType,
        note $textType,
        category $textType,
        dateTime $dateType
      )
    ''');
    await db.execute('''
      CREATE TABLE categories(
        id $idType,
        category $textType
        )

''');
  }

  Future<int> insertCategory(String category) async {
    final db = await instance.database;

    return await db.insert(
      'categories',
      {
        'category': category,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insert(Note note) async {
    final db = await instance.database;

    return await db.insert(
      'notes',
      NoteModel.fromEntity(note).toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> fetchCategories() async {
    final db = await instance.database;
    final maps = await db.query('categories');
    return List.generate(
        maps.length, (index) => maps[index]['category'].toString());
  }

  Future<List<Note>> fetchNotes() async {
    final db = await instance.database;
    final maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return Note(
        note: maps[i]['note'].toString(),
        category: maps[i]['category'].toString(),
        dateTime: DateTime.parse(maps[i]['dateTime'].toString()),
      );
    });
  }
}
