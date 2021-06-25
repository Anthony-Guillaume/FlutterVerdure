import 'package:equatable/equatable.dart';

typedef Plants = List<Plant>;

class PlantTable {
  static const String TABLE_NAME = 'plants';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String PRICE = 'price';
  static const String RELEASE_DATE = 'releaseDate';
  static const String SPECIES = 'species';
}

class Plant extends Equatable {
  const Plant(
      {required this.id,
      this.name,
      this.price,
      this.releaseDate,
      this.species});

  final int id;
  final String? name;
  final String? price;
  final String? releaseDate;
  final String? species;

  static const empty = Plant(id: -1);

  bool get isEmpty => this == Plant.empty;
  bool get isNotEmpty => this != Plant.empty;

  @override
  List<Object?> get props => [id, name, price, releaseDate, species];

  Map<String, dynamic> toMap() {
    return {
      PlantTable.ID: id,
      PlantTable.NAME: name,
      PlantTable.PRICE: price,
      PlantTable.RELEASE_DATE: releaseDate,
      PlantTable.SPECIES: species
    };
  }

  static Plant toPlant(Map<String, dynamic> map) {
    return Plant(
        id: map[PlantTable.ID],
        name: map[PlantTable.NAME],
        price: map[PlantTable.PRICE],
        releaseDate: map[PlantTable.RELEASE_DATE],
        species: map[PlantTable.SPECIES]);
  }
}
