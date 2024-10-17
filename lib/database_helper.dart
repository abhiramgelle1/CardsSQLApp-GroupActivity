import 'package:group_activity_cards_sql_app/card.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cards.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE folders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        suit TEXT,
        folderId INTEGER,
        imageUrl TEXT,
        FOREIGN KEY (folderId) REFERENCES folders(id)
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getCards(int folderId) async {
    final db = await database;
    return db.query('cards', where: 'folderId = ?', whereArgs: [folderId]);
  }

  Future<int> addCard(CardModel card) async {
    final db = await database;
    return db.insert('cards', card.toMap());
  }

  Future<int> deleteCard(int id) async {
    final db = await database;
    return db.delete('cards', where: 'id = ?', whereArgs: [id]);
  }
}
