import 'package:sqflite/sqflite.dart';

import '../medicine.dart';
import 'database_provider.dart';

class MedicineDatabaseProvider extends DatabaseProvider {
  @override
  String get databaseName => 'sample.db';

  @override
  String get tableName => "medicines";

  @override
  int get databaseVersion => 1;

  @override
  Future<void> createDatabase(Database db, int version) => db.execute(
        """
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            gs1code TEXT,
            medicineName TEXT,
            docType TEXT,
            url TEXT,
            favorite INTEGER
          )
        """,
      );

  Future<int> insertMedicine(Medicine medicine) async {
    final Database db = await database;
    return await db.insert(
      tableName,
      medicine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
