import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'entity/Plant.dart';

class SqlDatabase {
  static const _DB_VERSION = 5;
  static const _SQL_DB_PATH = 'assets/database/db.db';
  static final SqlDatabase _instance = SqlDatabase._internal();
  SqlDatabase._internal();
  Database? _db;

  factory SqlDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await _initDb();
      return _db!;
    }
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), _SQL_DB_PATH);
    var database = await openDatabase(path);
    if (await database.getVersion() < _DB_VERSION) {
      await database.close();
      await deleteDatabase(path);
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      var data = await rootBundle.load(_SQL_DB_PATH);
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
      database = await openDatabase(path);
      await database.setVersion(_DB_VERSION);
      await _createTables(database);
      await temporaryInsertPlantForTestPurpose(database);
    }
    return database;
  }

  Future<void> _createTables(Database database) async {
    await database.execute(
      'CREATE TABLE ${PlantTable.TABLE_NAME} (${PlantTable.ID} INTEGER PRIMARY KEY, ${PlantTable.NAME} TEXT, ${PlantTable.PRICE} TEXT, ${PlantTable.RELEASE_DATE} TEXT, ${PlantTable.SPECIES} TEXT)',
    );
  }

  Future<void> temporaryInsertPlantForTestPurpose(Database database) async {
    await database.transaction((txn) async {
      await txn.insert(PlantTable.TABLE_NAME, {
        PlantTable.ID: 0,
        PlantTable.NAME: 'Lys',
        PlantTable.PRICE: '5',
        PlantTable.RELEASE_DATE: '01/01/0000',
        PlantTable.SPECIES: 'Fleur'
      });
      await txn.insert(PlantTable.TABLE_NAME, {
        PlantTable.ID: 1,
        PlantTable.NAME: 'Marguerite',
        PlantTable.PRICE: '2',
        PlantTable.RELEASE_DATE: '01/01/0000',
        PlantTable.SPECIES: 'Fleur'
      });
      await txn.insert(PlantTable.TABLE_NAME, {
        PlantTable.ID: 2,
        PlantTable.NAME: 'Chêne',
        PlantTable.PRICE: '59',
        PlantTable.RELEASE_DATE: '01/01/0000',
        PlantTable.SPECIES: 'Arbre'
      });
      await txn.insert(PlantTable.TABLE_NAME, {
        PlantTable.ID: 3,
        PlantTable.NAME: 'Palmier',
        PlantTable.PRICE: '500',
        PlantTable.RELEASE_DATE: '01/01/0000',
        PlantTable.SPECIES: 'Arbre'
      });
      await txn.insert(PlantTable.TABLE_NAME, {
        PlantTable.ID: 4,
        PlantTable.NAME: 'Rose',
        PlantTable.PRICE: '25',
        PlantTable.RELEASE_DATE: '01/01/0000',
        PlantTable.SPECIES: 'Fleur'
      });
    });
  }
}
