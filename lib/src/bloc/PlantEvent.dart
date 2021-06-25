import 'package:equatable/equatable.dart';

abstract class PlantEvent extends Equatable {
  const PlantEvent();
  @override
  List<Object> get props => [];
}

class PlantFetched extends PlantEvent {}

class PlantAddToShoppingCart extends PlantEvent {
  const PlantAddToShoppingCart(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
