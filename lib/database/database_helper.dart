import 'package:sqflite/sqflite.dart';

import '../config/constant.dart';
import '../model/model_content.dart';

class DatabaseHelper {
  static Database _database;

  static Future<Database> createDatabase() async {
    _database = await openDatabase(
      Constant.databaseName,
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
          "CREATE TABLE ${Constant.tableName} "
          "("
          "${Constant.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT, "
          "${Constant.fieldContent} TEXT"
          ")",
        );
      },
    );
    return _database;
  }

  static Future<int> insert(ModelContent model) async {
    int _response = await _database.insert(
      Constant.tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return _response;
  }

  static Future<List<ModelContent>> readAll() async {
    List<Map<String, dynamic>> _maps = await _database.query(
      Constant.tableName,
    );
    if (_maps.length > 0) {
      return List.generate(
        _maps.length,
        (int index) {
          Map<String, dynamic> _field = _maps[index];
          return ModelContent(
            id: _field[Constant.fieldId],
            content: _field[Constant.fieldContent],
          );
        },
      );
    } else {
      return null;
    }
  }

  static Future<int> update(ModelContent model) async {
    int _response = await _database.update(
      Constant.tableName,
      model.toMap(),
      where: "${Constant.fieldId} = ?",
      whereArgs: [model.id],
    );
    return _response;
  }

  static Future<int> delete(int id) async {
    int _response = await _database.delete(
      Constant.tableName,
      where: "${Constant.fieldId} = ?",
      whereArgs: [id],
    );
    return _response;
  }
}
