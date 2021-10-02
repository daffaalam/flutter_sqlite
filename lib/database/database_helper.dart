import 'package:sqflite/sqflite.dart';

import '../common/constant.dart';
import '../model/model_content.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openDatabase(
      Constant.databaseName,
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
          'CREATE TABLE ${Constant.tableName} '
          '('
          '${Constant.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT, '
          '${Constant.fieldContent} TEXT'
          ')',
        );
      },
    );
    return _database!;
  }

  Future<int> insert(ModelContent model) async {
    Database db = await instance.database;
    int response = await db.insert(
      Constant.tableName,
      model.toMap(),
    );
    return response;
  }

  Future<List<ModelContent>> readAll() async {
    Database db = await instance.database;
    List<Map<String, Object?>> maps = await db.query(
      Constant.tableName,
    );
    return List<ModelContent>.generate(
      maps.length,
      (int index) {
        Map<String, Object?> field = maps[index];
        return ModelContent(
          id: field[Constant.fieldId] as int,
          content: field[Constant.fieldContent] as String,
        );
      },
    );
  }

  Future<int> update(ModelContent model) async {
    Database db = await instance.database;
    int response = await db.update(
      Constant.tableName,
      model.toMap(),
      where: "${Constant.fieldId} = ?",
      whereArgs: [model.id],
    );
    return response;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    int response = await db.delete(
      Constant.tableName,
      where: "${Constant.fieldId} = ?",
      whereArgs: [id],
    );
    return response;
  }
}
