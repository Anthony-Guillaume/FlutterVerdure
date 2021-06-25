import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verdure/src/Plant.dart';

import 'PlantItem.dart';

class PlantListView extends StatefulWidget {
  @override
  _PlantListViewState createState() => _PlantListViewState();
}

class _PlantListViewState extends State<PlantListView> {
  final _scrollController = ScrollController();
  late PlantBloc _plantBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _plantBloc = context.read<PlantBloc>();
    _plantBloc.add(PlantFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantBloc, PlantState>(
      builder: (context, state) {
        switch (state.status) {
          case PlantStatus.failure:
            return const Center(child: Text(''));
          case PlantStatus.success:
            if (state.plants.isEmpty) {
              return const Center(child: Text('No plants available'));
            }
            return multipleHorizontaleWidget(state.plants);
          case PlantStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _plantBloc.add(PlantFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Widget multipleHorizontaleWidget(Plants plants) {
    final Map<String, List<Plant>> species = {};
    for (var plant in plants) {
      var s = plant.species!;
      if (species.containsKey(s)) {
        species[s]!.add(plant);
      } else {
        species[s] = [plant];
      }
    }
    List<Widget> widgets = [];
    for (var entry in species.entries) {
      var horizontaleWidgets = horizontaleWidget(entry.key, entry.value);
      widgets += horizontaleWidgets;
    }
    return Scaffold(
      backgroundColor: Colors.white10,
      body: ListView(
        shrinkWrap: true,
        children: widgets,
      ),
    );
  }

  List<Widget> horizontaleWidget(String species, Plants plants) {
    return [
      Container(
          width: double.infinity,
          padding: EdgeInsets.all(4),
          color: Colors.blueGrey,
          margin: EdgeInsets.only(left: 8, top: 8, right: 8),
          child: Text(
            species,
            style: TextStyle(fontSize: 24, color: Colors.white),
          )),
      Container(
        color: Colors.white,
        margin: EdgeInsets.only(left: 8, right: 8),
        height: 160,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: plants
                .map((e) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        child: PlantItem(
                            plant: e,
                            onPressedShoppingCart: () {
                              _plantBloc.add(PlantAddToShoppingCart(e.id));
                            }),
                      ),
                    ))
                .toList()),
      )
    ];
  }
}
