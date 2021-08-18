import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_USER = 'user';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_NAME = 'name';
  static const String COLUMN_USERNAME = 'username';
  static const String COLUMN_EMAIL = 'email';
  static const String COLUMN_ADDRESS = 'address';
  static const String COLUMN_PHONE = 'phone';
  static const String COLUMN_WEBSITE = 'website';
  static const String COLUMN_COMPANY = 'company';

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database? _database;

  Future<Database?> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, 'userDB.db'), version: 1,
        onCreate: (Database database, int version) async {
      print("Creating user table");
      await database.execute("CREATE TABLE $TABLE_USER ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_NAME TEXT,"
          "$COLUMN_USERNAME TEXT,"
          "$COLUMN_EMAIL TEXT,"
          "$COLUMN_ADDRESS TEXT,"
          "$COLUMN_PHONE TEXT,"
          "$COLUMN_WEBSITE TEXT,"
          "$COLUMN_COMPANY TEXT,"
          ")");
    });
  }
}
