import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verdure/src/Authentication.dart';
import 'package:verdure/src/Plant.dart';
import 'package:verdure/src/bloc/ShoppingCartBloc.dart';
import 'package:verdure/src/ui/view/HomePage.dart';
import 'package:verdure/src/ui/view/LoginPage.dart';
import 'package:verdure/src/ui/view/PlantPage.dart';
import 'package:verdure/src/ui/view/ShoppingCartPage.dart';

class Routes {
  static const String LOGIN_PAGE = '/';
  static const String HOME_PAGE = '/home';
  static const String SHOPPING_CART_PAGE = '/shoppingCart';
  static const String PLANT_PAGE = '/plant';
}

class AppRouter {
  AppRouter(this.plantBloc, this.shoppingCartBloc);

  final PlantBloc plantBloc;
  final ShoppingCartBloc shoppingCartBloc;

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.LOGIN_PAGE:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case Routes.HOME_PAGE:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case Routes.SHOPPING_CART_PAGE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: shoppingCartBloc,
            child: ShoppingCartPage(),
          ),
        );
      case Routes.PLANT_PAGE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: plantBloc,
            child: PlantPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
    }
  }

  void dispose() {
    // plantBloc.dispose();
  }
}
