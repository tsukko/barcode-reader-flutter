import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'database_provider.dart';

abstract class MedicineDatabaseProvider extends DatabaseProvider {
  String databaseName = 'sample.db';
  int databaseVersion = 1;

  String tableName = "medicines";

  // DBのインスタンスはDatabaseで定義します
  Database db;

  // Pathの取得およびDBを開く処理は非同期のため初期化処理をasyncで囲みます。
  // Pathはsqflite の getDatbasePath()でも取得することができます。
  void init() async {
    final Directory documentDirectory =
        await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, databaseName);

    // openDatabaseメソッドを使用することでDBインスタンスを取得することができます。
    db = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
            CREATE TABLE $tableName
              (
                id INTEGER PRIMARY KEY,
                text TEXT,
                time INTEGER
              )
            """);
      },
    );
  }
}
