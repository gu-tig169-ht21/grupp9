import 'dart:convert';
import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/providers/favourites_provider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final String cocktail;
  const Details({Key? key, required this.cocktail}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  _DetailsState createState() => _DetailsState(cocktail: cocktail);
}

class _DetailsState extends State<Details> {
  final String cocktail;
  var url = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=';
  // ignore: prefer_typing_uninitialized_variables
  var res;
  // ignore: prefer_typing_uninitialized_variables
  var _cocktail;
  var favourites = [];
  // ignore: unused_element
  _DetailsState({Key? key, required this.cocktail});

  @override
  void initState() {
    super.initState();

    fetchCocktail();
    fetchFavourites();
  }

  fetchCocktail() async {
    res = await http.get(Uri.parse(url + cocktail));
    var drinks = jsonDecode(res.body)['drinks'][0];

    _cocktail = Cocktails.fromJson(drinks);

    setState(() {});
  }

  fetchFavourites() {
    favourites =
        Provider.of<FavouritesProvider>(context, listen: false).favourites;
  }

  bool checkFavourite(String drink) {
    return favourites.any((f) => f.title == drink);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.15),
        title: Text(
          (cocktail),
          style: const TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          FavoriteButton(
            iconSize: 30,
            isFavorite: checkFavourite(cocktail),
            valueChanged: (_isFavorite) {
              if (_isFavorite == true) {
                Provider.of<FavouritesProvider>(context, listen: false)
                    .addFavourite(cocktail, false);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$cocktail har lagts till i Favoriter! :)))'),
                ));
                fetchFavourites();
              } else {
                var f = favourites
                    .firstWhere((element) => element.title == cocktail);
                Provider.of<FavouritesProvider>(context, listen: false)
                    .removeFavourite(f);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('$cocktail har tagits bort från Favoriter! :((('),
                  ),
                );
                fetchFavourites();
              }
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Text((_cocktail == null) ? "" : _cocktail.strIngredient1,
                    style: const TextStyle(color: Colors.white)),
                Text((_cocktail == null) ? "" : _cocktail.strInstructions,
                    style: const TextStyle(color: Colors.white)),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                      height: 300,
                      child: Image.network((_cocktail == null)
                          ? "https://www.thecocktaildb.com/images/ingredients/gin-Small.png"
                          : _cocktail.strDrinkThumb)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
