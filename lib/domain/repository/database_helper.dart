import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model.dart';


class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  final dbName = 'NaverSearch';

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, '${dbName}.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${dbName}(
      id INTEGER PRIMARY KEY,
      name TEXT
    )
    ''');
  }

  Future<int> add(NaverSearch grocery) async {
    Database db = await instance.database;
    return await db.insert('$dbName', grocery.toMap());
  }

  Future<List<NaverSearch>> getGroceries() async {
    Database db = await instance.database;
    var groceries = await db.query('$dbName', orderBy: 'name');
    List<NaverSearch> groceryList = groceries.isNotEmpty
        ? groceries.map((c) => NaverSearch.fromMap(c)).toList()
        : [];
    return groceryList;
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('$dbName', where: 'id = ?', whereArgs: [id]);
  }
}