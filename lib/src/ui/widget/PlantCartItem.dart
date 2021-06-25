import 'package:flutter/material.dart';
import 'package:verdure/src/data/entity/Plant.dart';
import 'package:verdure/src/data/entity/PlantCart.dart';

class PlantCartItem extends StatelessWidget {
  const PlantCartItem(
      {Key? key,
      required this.plantBought,
      required this.onPressedShoppingCart})
      : super(key: key);

  final PlantBought plantBought;
  final void Function()? onPressedShoppingCart;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(children: [
      SizedBox(
          width: 100,
          height: 100,
          child: Image(image: AssetImage('assets/image/plante.jpg'))),
      Column(children: [
        Text('x ${plantBought.count}', style: textTheme.caption),
        Text('${plantBought.plant.name}'),
        Text('${plantBought.plant.species}'),
        Text('${plantBought.plant.price} €'),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: onPressedShoppingCart,
        ),
      ]),
    ]);
  }
}
