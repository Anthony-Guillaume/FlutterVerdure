import 'package:sqflite/sqflite.dart';
import 'package:verdure/src/data/LocalDatabase.dart';
import 'package:verdure/src/data/entity/Plant.dart';

class PlantDao {
  Future<int> generateId() async {
    Plants data = await getAll();
    return data.isEmpty ? 0 : data.last.id + 1;
  }

  Future<int> insert(Plant plant) async {
    var db = await LocalDatabase().sqlDb;
    return db.insert(
      PlantTable.TABLE_NAME,
      plant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Plants> getAll() async {
    var db = await LocalDatabase().sqlDb;
    var result = await db.query(PlantTable.TABLE_NAME);
    return result.map((value) => Plant.toPlant(value)).toList();
  }

  Future<Plant?> get(int id) async {
    var db = await LocalDatabase().sqlDb;
    var result = await db.query(
      PlantTable.TABLE_NAME,
      where: '${PlantTable.ID} = $id',
    );
    if (result.isEmpty) {
      return null;
    } else {
      return Plant.toPlant(result[0]);
    }
  }
}
