import 'package:bloc/bloc.dart';

import 'package:verdure/src/data/repository/PlantRepository.dart';
import 'package:verdure/src/data/repository/ShopingCartRepository.dart';

import 'ShoppingCartEvent.dart';
import 'ShoppingCartState.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc(
      {required this.plantRepository, required this.shopingCartRepository})
      : super(ShoppingCartState());

  PlantRepository plantRepository;
  ShoppingCartRepository shopingCartRepository;

  @override
  Stream<ShoppingCartState> mapEventToState(ShoppingCartEvent event) async* {
    if (event is ShoppingCartFetched) {
      yield state.copyWith(
          plantsBought: await shopingCartRepository.getPlants());
    } else if (event is ShoppingCartItemRemoved) {
      await shopingCartRepository.remove(event.id);
      yield state.copyWith(
          plantsBought: await shopingCartRepository.getPlants());
    }
  }
}
