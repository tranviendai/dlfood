// ignore_for_file: depend_on_referenced_packages
import 'package:dlfood/models/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbFavourite {
  // Singleton pattern
  static final DbFavourite _databaseService = DbFavourite._internal();
  factory DbFavourite() => _databaseService;
  DbFavourite._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'db_favourite.db');
    print(
        "Đường dẫn database: $databasePath"); // in đường dẫn chứa file database
    return await openDatabase(path, onCreate: _onCreate, version: 1
        // ,
        // onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
        );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE Favourite('
      'productID INTEGER, name TEXT, price FLOAT, img TEXT, des TEXT, count INTEGER)',
    );
  }

  Future<void> insertProduct(TempModel productModel) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('Favourite');
    if (await List.generate(maps.length, (index) => TempModel.fromMap(maps[index])).where((element) => element.productID == productModel.productID).length == 0) {
      await db.insert(
        'Favourite',
        productModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<TempModel>> products() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('Favourite');
    return List.generate(maps.length, (index) => TempModel.fromMap(maps[index]));
  }

  Future<TempModel> product(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('product', where: 'id = ?', whereArgs: [id]);
    return TempModel.fromMap(maps[0]);
  }

  Future<void> deleteProduct(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      'Favourite',
      where: 'productID = ?',
      whereArgs: [id],
    );
  }

  Future<void> clear() async {
    final db = await _databaseService.database;
    await db.delete('Favourite', where: 'count > 0');
  }
}
