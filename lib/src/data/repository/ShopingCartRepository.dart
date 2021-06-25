import 'dart:async';

import 'package:verdure/src/data/dao/PlantDao.dart';
import 'package:verdure/src/data/entity/Plant.dart';
import 'package:verdure/src/data/entity/PlantCart.dart';

class ShoppingCartRepository {
  final PlantCart _cache = PlantCart();
  PlantDao plantDao = PlantDao();

  Future<List<PlantBought>> getPlants() async {
    final List<PlantBought> result = [];
    for (var entry in _cache.idBought) {
      var plant = await plantDao.get(entry.id);
      if (plant != null) {
        result.add(PlantBought(entry.count, plant));
      }
    }
    return result;
  }

  Future<void> insert(int id) async {
    Plant? plant = await plantDao.get(id);
    if (plant == null) return;

    _cache.add(plant.id);
  }

  Future<void> remove(int id) async {
    Plant? plant = await plantDao.get(id);
    if (plant == null) return;
    _cache.remove(id);
  }
}
