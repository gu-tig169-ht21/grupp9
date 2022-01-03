import 'dart:convert';
import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/models/cocktails.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/providers/favourites_provider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final String cocktail;
  const Details({Key? key, required this.cocktail}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState(cocktail: cocktail);
}

class _DetailsState extends State<Details> {
  final String cocktail;
  var url = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=';
  var res;
  var _cocktail;
  var favourites = [];
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
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          actions: [
            FavoriteButton(
                iconSize: 30,
                isFavorite: checkFavourite(cocktail),
                valueChanged: (_isFavorite) {
                  fetchFavourites();
                  if (_isFavorite == true) {
                    Provider.of<FavouritesProvider>(context, listen: false)
                        .addFavourite(cocktail, false);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('$cocktail har lagts till i Favoriter! :)))'),
                    ));
                  } else {
                    var f = favourites
                        .firstWhere((element) => element.title == cocktail);
                    Provider.of<FavouritesProvider>(context, listen: false)
                        .removeFavourite(f);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          '$cocktail har tagits bort från Favoriter! :((('),
                    ));
                  }
                })
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (_cocktail != null)
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _cocktail.ingredientsList.length,
                            itemBuilder: (BuildContext context, index) {
                              if (index == 0) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text('Ingredients:',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 27)),
                                    const SizedBox(width: 42, height: 20),
                                    Text(_cocktail.ingredientsList[index],
                                        style: const TextStyle(
                                            color: Colors.white))
                                  ],
                                );
                              } else {
                                return Text(_cocktail.ingredientsList[index],
                                    style:
                                        const TextStyle(color: Colors.white));
                              }
                            })
                        : const Text('No ingredients found.',
                            style: TextStyle(color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                          height: 300,
                          child: Image.network((_cocktail == null)
                              ? "https://www.thecocktaildb.com/images/ingredients/gin-Small.png"
                              : _cocktail.strDrinkThumb)),
                    ),
                    const Text(
                      'Instructions:',
                      style: TextStyle(color: Colors.white, fontSize: 27),
                    ),
                    const SizedBox(width: 42, height: 20),
                    Text((_cocktail == null) ? "" : _cocktail.strInstructions,
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            )));
  }
}
