import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verdure/src/Authentication.dart';
import 'package:verdure/src/Plant.dart';
import 'package:verdure/src/data/repository/PlantRepository.dart';
import 'package:verdure/src/ui/router/AppRouter.dart';
import 'package:verdure/src/ui/widget/PlantListView.dart';
import 'package:verdure/src/ui/widget/PublishPlantForm.dart';

class PlantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final plantBloc = BlocProvider.of<PlantBloc>(context);
    return WillPopScope(
        onWillPop: () async {
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationLogoutRequested());
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Plants'),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested())),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_rounded),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.SHOPPING_CART_PAGE);
                },
              ),
              IconButton(
                icon: const Icon(Icons.portrait),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.HOME_PAGE);
                },
              ),
            ],
          ),
          body: BlocProvider.value(
            value: plantBloc,
            child: PlantListView(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext _) {
                  return MultiBlocProvider(providers: [
                    BlocProvider.value(value: plantBloc),
                    BlocProvider<PlantFormBloc>(
                        create: (_) => PlantFormBloc(
                            plantRepository:
                                RepositoryProvider.of<PlantRepository>(
                                    context)))
                  ], child: PublishPlantForm());
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}
