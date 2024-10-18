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
    // Create folders table (for suits)
    await db.execute('''
      CREATE TABLE folders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create cards table
    await db.execute('''
      CREATE TABLE cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        suit TEXT,
        imageUrl TEXT,
        folderId INTEGER,
        FOREIGN KEY (folderId) REFERENCES folders(id)
      )
    ''');

    // Prepopulate folders (Hearts, Diamonds, Spades, Clubs)
    await db.insert('folders', {'name': 'Hearts'});
    await db.insert('folders', {'name': 'Diamonds'});
    await db.insert('folders', {'name': 'Spades'});
    await db.insert('folders', {'name': 'Clubs'});

    // Prepopulate all cards with actual URLs
    await _prepopulateCards(db);
  }

  Future _prepopulateCards(Database db) async {
    // Hearts cards
    await db.insert('cards', {
      'name': 'Ace of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/AH.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': '2 of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/2H.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': '3 of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/3H.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': '4 of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/4H.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': '5 of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/5H.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': '6 of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/6H.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': '7 of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/7H.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': '8 of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/8H.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': '9 of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/9H.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': '10 of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/0H.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': 'Jack of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/JH.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': 'Queen of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/QH.png',
      'folderId': 1
    });
    await db.insert('cards', {
      'name': 'King of Hearts',
      'suit': 'Hearts',
      'imageUrl': 'https://deckofcardsapi.com/static/img/KH.png',
      'folderId': 1
    });

    // Diamonds cards
    await db.insert('cards', {
      'name': 'Ace of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/AD.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': '2 of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/2D.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': '3 of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/3D.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': '4 of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/4D.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': '5 of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/5D.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': '6 of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/6D.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': '7 of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/7D.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': '8 of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/8D.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': '9 of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/9D.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': '10 of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/0D.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': 'Jack of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/JD.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': 'Queen of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/QD.png',
      'folderId': 2
    });
    await db.insert('cards', {
      'name': 'King of Diamonds',
      'suit': 'Diamonds',
      'imageUrl': 'https://deckofcardsapi.com/static/img/KD.png',
      'folderId': 2
    });

    // Spades cards
    await db.insert('cards', {
      'name': 'Ace of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/AS.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': '2 of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/2S.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': '3 of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/3S.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': '4 of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/4S.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': '5 of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/5S.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': '6 of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/6S.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': '7 of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/7S.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': '8 of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/8S.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': '9 of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/9S.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': '10 of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/0S.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': 'Jack of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/JS.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': 'Queen of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/QS.png',
      'folderId': 3
    });
    await db.insert('cards', {
      'name': 'King of Spades',
      'suit': 'Spades',
      'imageUrl': 'https://deckofcardsapi.com/static/img/KS.png',
      'folderId': 3
    });

    // Clubs cards
    await db.insert('cards', {
      'name': 'Ace of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/AC.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': '2 of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/2C.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': '3 of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/3C.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': '4 of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/4C.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': '5 of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/5C.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': '6 of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/6C.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': '7 of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/7C.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': '8 of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/8C.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': '9 of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/9C.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': '10 of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/0C.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': 'Jack of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/JC.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': 'Queen of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/QC.png',
      'folderId': 4
    });
    await db.insert('cards', {
      'name': 'King of Clubs',
      'suit': 'Clubs',
      'imageUrl': 'https://deckofcardsapi.com/static/img/KC.png',
      'folderId': 4
    });
  }

  // Fetch cards for a specific folder
  Future<List<Map<String, dynamic>>> getCards(int folderId) async {
    final db = await database;
    return db.query('cards', where: 'folderId = ?', whereArgs: [folderId]);
  }

  // Add a new card
  Future<int> addCard(Map<String, dynamic> card) async {
    final db = await database;
    return db.insert('cards', card);
  }

  // Delete a card
  Future<int> deleteCard(int id) async {
    final db = await database;
    return db.delete('cards', where: 'id = ?', whereArgs: [id]);
  }

  // Check if a folder can add more cards (limit to 6 cards)
  Future<bool> canAddCard(int folderId) async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM cards WHERE folderId = ?',
      [folderId],
    ));
    return count != null && count < 6;
  }
}
