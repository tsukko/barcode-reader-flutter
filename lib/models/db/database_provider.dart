import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseProvider {
  Database _instance;

  String get databaseName;

  String get tableName;

  Future<Database> get database async {
    if (_instance == null) {
      _instance = await openDatabase(
        join(
          await getDatabasesPath(),
          databaseName,
        ),
        onCreate: createDatabase,
        version: 1,
      );
    }
    return _instance;
  }

  // DBがpathに存在しなかった場合に onCreateメソッドが呼ばれます。
  // （https://iganin.hatenablog.com/entry/2019/01/09/010804 より）
  // ignore: type_annotate_public_apis
  Future<Database> createDatabase(Database db, int version);
}
