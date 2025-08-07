import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper();

  Database? _database;

  static const String _databaseName = 'attendance.db';
  static const int _databaseVersion = 1;

  final String attendanceTableName = 'attendance';

  Future<Database> get database async {
    _database ??= await _initialize();

    return _database!;
  }

  Future<String> get fullPath async {
    final String path = await getDatabasesPath();

    return join(path, _databaseName);
  }

  Future<Database> _initialize() async {
    final String path = await fullPath;

    Database database = await openDatabase(path, version: _databaseVersion, onCreate: _create);

    return database;
  }

  Future<void> _create(Database database, int version) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $attendanceTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        status TEXT NOT NULL,
        image_path TEXT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );
    ''');
  }
}
