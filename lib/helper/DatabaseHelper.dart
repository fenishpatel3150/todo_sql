import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? database;

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'Employee.db');

    database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        String query = '''
          CREATE TABLE Employee(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          salary REAL NOT NULL,
          role TEXT)
        ''';
        db.execute(query);
        },
    );
    return database;
  }

  Future<void> insertData(String name, String salary, String role) async {
    String sql = '''
      INSERT INTO Employee (name, salary, role)
      VALUES(fenish, 10000, flutter devloper)
    ''';
    await database!.rawInsert(sql, [name, salary, role]);
  }

  Future<List<Map<String, dynamic>>> fetchData() async {

    if (database != null) {
      String sql = 'SELECT * FROM Employee';
      Database? db = await initDatabase();
      return  db!.rawQuery(sql);
    } else {
      return [];
    }
  }

  Future<void> deleteData(int id) async {
    String sql = '''
      DELETE FROM Employee WHERE id = $id
    ''';
    await database!.rawDelete(sql, [id]);
  }
}
