import 'package:sqflite/sqflite.dart';
import 'package:verdure/src/data/SqlDatabase.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  LocalDatabase._internal();

  factory LocalDatabase() {
    return _instance;
  }

  Future<Database> get sqlDb async {
    return SqlDatabase().db;
  }
}
