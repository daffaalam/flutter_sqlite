import 'package:flutter_sqlite/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database;
  static final String _databaseName = 'database_users.db';
  static final String _tableName = 'users';
  static final String _id = 'id';
  static final String _name = 'name';
  static final String _email = 'email';

  // function for create and open database
  static void createDatabase() async {
    database = openDatabase(
      // set path where database will be saved
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async {
        // on database created, create table too
        await db.execute(
          'CREATE TABLE $_tableName ($_id INTEGER PRIMARY KEY AUTOINCREMENT, $_name TEXT, $_email TEXT)',
        );
      },
      // version of database
      version: 1,
    );
  }

  static Future<void> insertUser(User user) async {
    Database db = await database;
    // waiting for insert to database
    await db.insert(
      _tableName,
      user.toMap(),
      // if data conflict, replace data
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<User>> readUsers() async {
    Database db = await database;
    // waiting for read all data on table
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    if (maps.length != 0) {
      // if data more then 0, create data to list of user
      return List.generate(maps.length, (i) {
        return User(
          id: maps[i][_id],
          name: maps[i][_name],
          email: maps[i][_email],
        );
      });
    } else {
      return null;
    }
  }

  static Future<User> readUser(int idUser) async {
    Database db = await database;
    // waiting for read specific data on table where id ?
    List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: '$_id = ?',
      whereArgs: [idUser],
    );
    // if there is 1 data, return user
    if (maps.length == 1) {
      return User(
        id: maps[0][_id],
        name: maps[0][_name],
        email: maps[0][_email],
      );
    } else {
      return null;
    }
  }

  static Future<void> updateUser(User user) async {
    Database db = await database;
    // waiting for update specific data on table where id ?
    await db.update(
      _tableName,
      user.toMap(),
      where: '$_id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<void> deleteUser(int idUser) async {
    Database db = await database;
    // waiting for delete specific data on table where id ?
    await db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [idUser],
    );
  }
}
