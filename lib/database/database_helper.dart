import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:demologin/home/image_model.dart'; // Import your ImageModel class

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'images.db');
    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        path TEXT,
        size REAL
      )
    ''');
  }

  Future<void> insertImage(ImageModel imageModel) async {
    final db = await database;
    await db.insert('images', imageModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteImage(ImageModel imageModel) async {
    final db = await database;
    await db.delete('images', where: 'id = ?', whereArgs: [imageModel.id]);
  }

  Future<void> editNameImage(ImageModel imageModel) async {
    final db = await database;
    await db.update('images', {'name': imageModel.name},
        where: 'id = ?', whereArgs: [imageModel.id]);
  }

  Future<List<ImageModel>> getImages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('images');
    return List.generate(maps.length, (i) {
      return ImageModel.fromMap(maps[i]);
    });
  }
}
