import 'package:flutter/material.dart';
import 'package:verdure/src/data/entity/Plant.dart';

class PlantItem extends StatelessWidget {
  const PlantItem({Key? key, required this.plant, this.onPressedShoppingCart})
      : super(key: key);

  final Plant plant;
  final void Function()? onPressedShoppingCart;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 160.0,
      child: Column(children: [
        SizedBox(
            width: 60,
            height: 60,
            child: Image(image: AssetImage('assets/image/plante.jpg'))),
        Text('${plant.name}', style: textTheme.caption),
        Text('${plant.price} €'),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: onPressedShoppingCart,
        ),
      ]),
    );
  }
}
