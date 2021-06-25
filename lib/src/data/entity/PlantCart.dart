import 'package:equatable/equatable.dart';
import 'package:verdure/src/Plant.dart';

class PlantCart extends Equatable {
  final List<IdBought> idBought = [];

  void add(int id) {
    for (var p in idBought) {
      if (p.id == id) {
        ++p.count;
        return;
      }
    }
    idBought.add(IdBought(1, id));
  }

  void remove(int id) {
    for (var p in idBought) {
      if (p.id == id) {
        if (p.count == 1) {
          idBought.remove(p);
        } else {
          --p.count;
        }
        return;
      }
    }
  }

  @override
  List<Object?> get props => [idBought];
}

class IdBought {
  IdBought(this.count, this.id);
  int count;
  final int id;

  // @override
  // List<Object?> get props => [count, id];
}

class PlantBought {
  PlantBought(this.count, this.plant);
  int count;
  final Plant plant;

  // @override
  // List<Object?> get props => [count, id];
}
