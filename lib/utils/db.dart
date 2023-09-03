import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Product.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Employee(id INTEGER PRIMARY KEY, email TEXT, password TEXT)");
    await db.execute(
        "CREATE TABLE Product(id INTEGER PRIMARY KEY, picture TEXT, title TEXT, description TEXT, price TEXT, time TEXT)");
    print("Created tables");
  }

  void saveProduct(Product item ) async {
    var dbClient = await db;
    await dbClient!.transaction((txn) async {
      return await txn.rawInsert(
          "INSERT INTO Product (picture, title, description, price,time) VALUES('${item.picture
          }','${item.title}','${item.description}','${item.price}','${item.time}')");
    });
  }
  Future<List<Product>> getProduct() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM Product');
    print(list);
    List<Product> item = [];
    for (int i = 0; i < list.length; i++) {
      item.add(Product(list[i]['id'], list[i]['picture'],
          list[i]['title'],list[i]['description'],list[i]['price'],list[i]['time']));
    }
    print(item);
    return item;
  }


  void deleteProduct(int id) async {
    var dbClient = await db;
    var list = await dbClient!.rawDelete('DELETE FROM Product WHERE id = $id');
    print(list);
  }


  void updateProduct(Product item) async {
    var dbClient = await db;
    var sql =
        "UPDATE Product SET picture='${item.picture}',title='${item.title}',description='${item.description}',price='${item.price}',time='${item.time}' WHERE id=${item.id}";
    print(sql);
    var update = await dbClient!.rawUpdate(sql);
    print(update);
    print("Data Updated");
  }
}
