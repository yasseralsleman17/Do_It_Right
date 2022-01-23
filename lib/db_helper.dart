import 'package:doitright/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database _db;
  List productName = [];

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database _database;

  DatabaseHelper._init();

  static String tableName = 'UserTable';

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB('notes.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableName ( 
  ${UserModel.ID} INTEGER PRIMARY KEY AUTOINCREMENT,  
  ${UserModel.NAME} TEXT NOT NULL, 
  ${UserModel.PASSWORD} TEXT NOT NULL
  )
''');
  }


  Future<int> addUser(UserModel user) async {

    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: UserModel.values,
      where: '${UserModel.NAME} = ?',
      whereArgs: [user.name],
    ) ?? "null" ;
    print("11111111111"+maps.toString());
    if (maps.toString()=="[]") {

      final id = await db.insert(tableName, user.toJson());
      return id;

    }
    return 0;
  }

  Future<UserModel> getUser(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableName,
      columns: UserModel.values,
      where: '${UserModel.ID} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List> searchUser(String userName) async {
    print(userName);

    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: UserModel.values,
      where: '${UserModel.NAME} = ?',
      whereArgs: [userName],
    );

    return maps.toList();
  }
}
