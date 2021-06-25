import 'package:bloc/bloc.dart';

import 'package:verdure/src/bloc/PlantEvent.dart';
import 'package:verdure/src/bloc/PlantState.dart';
import 'package:verdure/src/data/repository/PlantRepository.dart';
import 'package:verdure/src/data/repository/ShopingCartRepository.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  PlantBloc(
      {required this.plantRepository, required this.shopingCartRepository})
      : super(const PlantState());

  PlantRepository plantRepository;
  ShoppingCartRepository shopingCartRepository;

  @override
  Stream<PlantState> mapEventToState(PlantEvent event) async* {
    if (event is PlantFetched) {
      yield state.copyWith(
          status: PlantStatus.success,
          plants: await plantRepository.getPlants());
    } else if (event is PlantAddToShoppingCart) {
      await shopingCartRepository.insert(event.id);
    }
  }
}
