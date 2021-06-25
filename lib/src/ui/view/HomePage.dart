import 'package:flutter/material.dart';
import 'package:verdure/src/ui/router/AppRouter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.of(context).pushNamed(Routes.PLANT_PAGE)),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Text('My profile')],
        ),
      ),
    );
  }
}
