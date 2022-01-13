import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_first_app/providers/cocktails_provider.dart';
import 'package:provider/provider.dart';
import 'details.dart';
import 'package:my_first_app/models/favourites.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/4.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.black12.withOpacity(0.85),
                  title: const Text(
                    'Favourites',
                  ),
                ),
                body: Consumer<CocktailsProvider>(
                    builder: (context, CocktailsProvider data, child) {
                  return ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: data.favourites
                          .map((card) => ListItem(context, card))
                          .toList());
                }),
              )))
    ]);
  }
}

Widget deleteButton(BuildContext context, item, String drink) {
  return IconButton(
    icon: const Icon(Icons.delete_outline),
    color: Colors.red[300],
    tooltip: "Delete",
    onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.black,
        content:
            Text("Are you sure you want to delete '$drink' from favourites?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<CocktailsProvider>(context, listen: false)
                  .removeFavourite(item);
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

class ListItem extends StatelessWidget {
  final FavouritesModel item;
  final BuildContext context;
  const ListItem(this.context, this.item, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.black12.withOpacity(0.4),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Details(cocktail: item.title)),
            );
          },
          title: Text(item.title, style: const TextStyle(fontSize: 21)),
          trailing: deleteButton(context, item, item.title),
        ));
  }
}
