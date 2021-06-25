import 'package:equatable/equatable.dart';
import 'package:verdure/src/data/entity/PlantCart.dart';

class ShoppingCartState extends Equatable {
  ShoppingCartState({this.plantsBought = const <PlantBought>[]});

  final List<PlantBought> plantsBought;

  ShoppingCartState copyWith({List<PlantBought>? plantsBought}) {
    return ShoppingCartState(plantsBought: plantsBought ?? this.plantsBought);
  }

  @override
  List<Object> get props => [plantsBought];
}
