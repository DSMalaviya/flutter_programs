import 'package:flutter/material.dart';
import 'package:great_place/providers/great_places.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: const Text('no added places plase ad it'),
                    ),
                    builder: (context, greatplaces, ch) =>
                        greatplaces.items.length <= 0
                            ? ch
                            : ListView.builder(
                                itemBuilder: (ctx, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(greatplaces.items[i].image),
                                  ),
                                  title: Text(greatplaces.items[i].title),
                                  onTap: () {},
                                ),
                                itemCount: greatplaces.items.length,
                              ),
                  ),
      ),
    );
  }
}
