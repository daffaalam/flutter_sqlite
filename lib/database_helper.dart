import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class DatabaseHelper {
  static Future<Database> database;
  static final Future<Directory> _directory = getExternalStorageDirectory();
  static final String _databaseName = "eudeka.db";
  static final String _tableName = "flutter_basic";
  static final String _id = "id";
  static final String _content = "content";

  static void createDatabase() async {
    database = openDatabase(
      join((await _directory).path, _databaseName),
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE $_tableName ("
          "$_id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "$_content TEXT"
          ")",
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(Model model) async {
    Database db = await database;
    await db.insert(
      _tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  static Future<List<Model>> readAll() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    if (maps.length > 0) {
      return List.generate(
        maps.length,
        (int index) {
          return Model(
            id: maps[index][_id],
            content: maps[index][_content],
          );
        },
      );
    } else {
      return null;
    }
  }

  static Future<Model> read(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: "$_id = ?",
      whereArgs: [id],
    );
    if (maps.length == 1) {
      return Model(
        id: maps[0][_id],
        content: maps[0][_content],
      );
    } else {
      return null;
    }
  }

  static Future<void> update(Model model) async {
    Database db = await database;
    await db.update(
      _tableName,
      model.toMap(),
      where: "$_id = ?",
      whereArgs: [model.id],
    );
  }

  static Future<void> delete(int id) async {
    Database db = await database;
    await db.delete(
      _tableName,
      where: "$_id = ?",
      whereArgs: [id],
    );
  }
}
