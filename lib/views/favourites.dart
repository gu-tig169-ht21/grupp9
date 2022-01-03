import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_first_app/providers/favourites_provider.dart';
import 'package:provider/provider.dart';
import 'details.dart';
import 'package:my_first_app/models/favourites.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        title: const Center(
                          child: Text(
                            'Favourites',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      backgroundColor: Colors.black12.withOpacity(0.65),
                      elevation: 0.0,
                    ),
                    body: SizedBox(
                      height: 590,
                      child: Consumer<FavouritesProvider>(
                          builder: (context, FavouritesProvider data, child) {
                        return ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: data.favourites
                                .map((card) => ListItem(context, card))
                                .toList());
                      }),
                    ),
                  ))))
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
        title: const Text('Varning'),
        content: Text(
            "Är du säker på att du vill radera '$drink' från dina favoriter?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Avbryt'),
          ),
          TextButton(
            onPressed: () async {
              Provider.of<FavouritesProvider>(context, listen: false)
                  .removeFavourite(item);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    ),
  );
}

class ListItem extends StatelessWidget {
  final FavouritesModel item;
  BuildContext context;
  ListItem(this.context, this.item, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
              margin: const EdgeInsets.all(0.7),
              color: Colors.black12.withOpacity(0.4),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(cocktail: item.title)),
                  );
                },
                title: Text(item.title, style: TextStyle(fontSize: 21)),
                trailing: deleteButton(context, item, item.title),
              )));
    });
  }
}
