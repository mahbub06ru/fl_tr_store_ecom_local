
import 'package:ecom/model/product_cart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/product_list.dart';

class DatabaseHelperCart {
  static const _databaseName = "cart.db";
  static const _databaseVersion = 1;

  static const table = "cart";

  static const columnId = 'col_id';
  static const id = 'id';
  static const title = 'title';
  static const content = 'content';
  static const userId = 'userId';
  static const image = 'image';
  static const thumbnail = 'thumbnail';
  static const quantity = 'quantity'; // Add quantity column

  DatabaseHelperCart._privateConstructor();

  static final DatabaseHelperCart instance = DatabaseHelperCart._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
             $columnId INTEGER PRIMARY KEY AUTOINCREMENT,      
             $id String NOT NULL,
             $title String NOT NULL,
             $content String NOT NULL,       
             $userId String NOT NULL,     
             $image String NOT NULL,     
             $thumbnail String NOT NULL,
             $quantity INTEGER NOT NULL DEFAULT 1
          )
          ''');
  }

  Future<int> insert(ProductCart todo) async {
    Database? db = await instance.database;
    var res = await db!.insert(table, todo.toJson());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    var res = await db!.query(table, orderBy: "$columnId ASC");
    return res;
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> clearTable() async {
    Database? db = await instance.database;
    await db!.rawQuery("DELETE FROM $table");
  }

  Future<void> incrementQuantity(String productId) async {
    Database? db = await instance.database;
    await db!.rawUpdate(
        'UPDATE $table SET $quantity = $quantity + 1 WHERE $id = ?', [productId]);
  }

  Future<void> decrementQuantity(String productId) async {
    Database? db = await instance.database;
    await db!.rawUpdate(
        'UPDATE $table SET $quantity = $quantity - 1 WHERE $id = ?', [productId]);
  }
}


