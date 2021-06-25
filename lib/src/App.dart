import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verdure/src/Authentication.dart';
import 'package:verdure/src/bloc/PlantBloc.dart';
import 'package:verdure/src/data/repository/PlantRepository.dart';
import 'package:verdure/src/data/repository/UserRepository.dart';
import 'package:verdure/src/ui/router/AppRouter.dart';

import 'ShoppingCart.dart';
import 'data/repository/ShopingCartRepository.dart';

class App extends StatelessWidget {
  App(
      {Key? key,
      required this.authenticationRepository,
      required this.userRepository,
      required this.plantRepository,
      required this.shopingCartRepository})
      : authenticationBloc = AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository),
        plantBloc = PlantBloc(
            plantRepository: plantRepository,
            shopingCartRepository: shopingCartRepository),
        shoppingCartBloc = ShoppingCartBloc(
            plantRepository: plantRepository,
            shopingCartRepository: shopingCartRepository),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final PlantRepository plantRepository;
  final ShoppingCartRepository shopingCartRepository;

  final AuthenticationBloc authenticationBloc;
  final PlantBloc plantBloc;
  final ShoppingCartBloc shoppingCartBloc;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PlantRepository>(
            create: (context) => plantRepository),
        RepositoryProvider<UserRepository>(create: (context) => userRepository),
        RepositoryProvider<AuthenticationRepository>(
            create: (context) => authenticationRepository),
      ],
      child: BlocProvider.value(
        value: authenticationBloc,
        child: AppView(plantBloc, shoppingCartBloc),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  final AppRouter appRouter;
  AppView(plantBloc, shoppingCartBloc)
      : appRouter = AppRouter(plantBloc, shoppingCartBloc);

  @override
  _AppViewState createState() => _AppViewState(appRouter);
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  final AppRouter _appRouter;

  _AppViewState(this._appRouter);

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushNamed(Routes.PLANT_PAGE);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushNamed(Routes.LOGIN_PAGE);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
