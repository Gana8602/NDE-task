import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:news_app/model/news_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'news.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE news (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        date TEXT,
        image TEXT,
        content TEXT,
        source TEXT
      )
    ''');
  }

  Future<void> insertNews(NewsModel news) async {
    final db = await database;
    await db?.insert('news', news.toMap());
  }

  Future<List<NewsModel>> getNews({int limit = 10, int offset = 0}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(
      'news',
      limit: limit,
      offset: offset,
    );
    return List.generate(maps.length, (i) {
      return NewsModel.fromJson(maps[i]);
    });
  }

  Future<int> deleteAllNews() async {
    final db = await database;
    return await db!.delete('news'); // Delete without condition
  }
}
