import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verdure/src/ShoppingCart.dart';
import 'package:verdure/src/ui/router/AppRouter.dart';
import 'package:verdure/src/ui/widget/PlantCartItem.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late ShoppingCartBloc _shoppingCartBloc;

  @override
  void initState() {
    super.initState();
    _shoppingCartBloc = context.read<ShoppingCartBloc>();
    _shoppingCartBloc.add(ShoppingCartFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Plants'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.PLANT_PAGE)),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_rounded),
              onPressed: () {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Transaction in progress')),
                  );
              },
            ),
          ],
        ),
        body: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
            builder: (context, state) {
          return state.plantsBought.isEmpty
              ? Text('Your shopping cart is empty')
              : ListView(
                  children: state.plantsBought
                      .map((e) => PlantCartItem(
                          plantBought: e,
                          onPressedShoppingCart: () {
                            _shoppingCartBloc
                                .add(ShoppingCartItemRemoved(e.plant.id));
                          }))
                      .toList(),
                );
        }));
  }
}
