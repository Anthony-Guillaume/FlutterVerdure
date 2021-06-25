import 'dart:async';

import 'package:intl/intl.dart';
import 'package:verdure/src/data/dao/PlantDao.dart';
import 'package:verdure/src/data/entity/Plant.dart';

class PlantRepository {
  Plants? _cache;
  PlantDao plantDao = PlantDao();

  Future<Plants> getPlants() async {
    if (_cache != null) {
      return _cache!;
    }
    _cache = await plantDao.getAll();
    return _cache!;
  }

  Future<void> insert(String? name, String? price, String? species) async {
    final dateFormatter = DateFormat('dd-MM-yyyy');
    final date = dateFormatter.format(DateTime.now());
    await plantDao.insert(Plant(
        id: await plantDao.generateId(),
        name: name,
        price: price,
        species: species,
        releaseDate: date.toString()));
    _cache = await plantDao.getAll();
  }
}
