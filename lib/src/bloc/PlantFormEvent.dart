import 'package:equatable/equatable.dart';

abstract class PlantFormEvent extends Equatable {
  const PlantFormEvent();

  @override
  List<Object> get props => [];
}

class PlantNameChanged extends PlantFormEvent {
  const PlantNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class PlantPriceChanged extends PlantFormEvent {
  const PlantPriceChanged(this.price);

  final String price;

  @override
  List<Object> get props => [price];
}

class PlantSpeciesChanged extends PlantFormEvent {
  const PlantSpeciesChanged(this.species);

  final String species;

  @override
  List<Object> get props => [species];
}

class PlantSubmitted extends PlantFormEvent {
  const PlantSubmitted();
}
