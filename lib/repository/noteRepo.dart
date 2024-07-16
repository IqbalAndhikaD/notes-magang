
// ignore_for_file: file_names, camel_case_types

import 'package:notes/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class noteRepo {
  static const _dbfile = 'file_database.db';
  static const _tablefile = 'file';

  static Future<Database> _database() async {
    final database = openDatabase(
      join(await getDatabasesPath(), _dbfile),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $_tablefile(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createAt TEXT)');
      },
      version: 1,
    );
    return database;
  }

  static insert({required Note note}) async {
    final db = await _database();
    await db.insert(
      _tablefile,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Note>> getNotes() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tablefile);
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        description: maps[i]['description'] as String,
        createAt: DateTime.parse(maps[i]['createAt']),
      );
    });
  }

  static update({required Note note}) async {
    final db = await _database();
    await db.update(
      _tablefile,
      note.toMap(),
      where: 'id =?',
      whereArgs: [note.id],
    );
  }

  static delete({required Note note}) async {
    final db = await _database();
    await db.delete(
      _tablefile,
      where: 'id =?',
      whereArgs: [note.id],
    );
  }
}