import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  DbController._();

  late Database _database;
  static DbController? _instance;

  factory DbController() {
    return _instance ??= DbController._();
  }
 Database get database => _database;
  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'app_db.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database database) {},
      onCreate: (Database database, int version) async{
        await database.execute('''
        CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        total REAL NOT NULL
        )
        ''');
        await database.execute('''
        CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL
        )
        ''');
        //        order_time DATETIME,
        await database.execute('''
        CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER,
        user_id INTEGER,
        quantity INTEGER,
        order_time TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (product_id) REFERENCES products(id)
        )
        ''');
      },
      onUpgrade: (Database database, int oldVersion, int newVersion) {},
      onDowngrade: (Database database, int oldVersion, int newVersion) {},
    );
  }
}
