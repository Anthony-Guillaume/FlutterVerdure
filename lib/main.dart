import 'package:flutter/widgets.dart';
import 'package:verdure/src/App.dart';
import 'package:verdure/src/Authentication.dart';
import 'package:verdure/src/data/repository/PlantRepository.dart';
import 'package:verdure/src/data/repository/ShopingCartRepository.dart';
import 'package:verdure/src/data/repository/UserRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
    plantRepository: PlantRepository(),
    shopingCartRepository: ShoppingCartRepository(),
  ));
}
